{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/os9-0)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program Attr;

Uses DOS;

Var
 Language:(_French,_English,_Germany,_Italian,_Spain);
 IsAttrSetting:Array[Byte]of Boolean;
 AttrAdd,AttrRemove:Word;
 I:Byte;
 SubDirectory,ShowChanged:Boolean;
 CurrAttr:Word;
 TmpLanguage:String;

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Function Path2Dir(Const Path:String):String;
Var
 D:DirStr;
 N:NameStr;
 E:ExtStr;
Begin
 Path2Dir:='';
 If Path=''Then Exit;
 FSplit(Path,D,N,E);
 If E=''Then Begin
  If D[Length(D)]<>'\'Then D:=D+'\';
  D:=D+E;
 End;
 If D=''Then Path2Dir:='' Else
 If D[Length(D)]<>'\'Then D:=D+'\';
 Path2Dir:=D;
End;

Function SetPath4AddFile(Path:String):String;Begin
 If Path=''Then GetDir(0,Path);
 If Path[Length(Path)]<>'\'Then Path:=Path+'\';
 SetPath4AddFile:=Path;
End;

Procedure SetAttribut(Var F:File);
Begin
 GetFAttr(F,CurrAttr);
 If AttrRemove and ReadOnly=ReadOnly Then CurrAttr:=CurrAttr and Not ReadOnly;
 If AttrRemove and Archive=Archive Then CurrAttr:=CurrAttr and Not Archive;
 If AttrRemove and Hidden=Hidden Then CurrAttr:=CurrAttr and Not Hidden;
 If AttrRemove and SysFile=SysFile Then CurrAttr:=CurrAttr and Not SysFile;

 If AttrAdd and ReadOnly=ReadOnly Then CurrAttr:=CurrAttr or ReadOnly;
 If AttrAdd and Archive=Archive Then CurrAttr:=CurrAttr or Archive;
 If AttrAdd and Hidden=Hidden Then CurrAttr:=CurrAttr or Hidden;
 If AttrAdd and SysFile=SysFile THen CurrAttr:=CurrAttr or SysFile;
 SetFAttr(F,CurrAttr);
End;

Procedure SetAttributFiles(FileSpec:String);
Var
 Info:SearchRec;
 CurrFile:File;
 Found:Boolean;
Begin
 FileSpec:=FExpand(FileSpec);
 FindFirst(FileSpec,AnyFile,Info);
 Found:=False;
 While DOSError=0 do Begin
  Found:=True;
  If Info.Attr and Directory=Directory Then Begin
   If(SubDirectory)Then Begin
    If Not((Info.Name='.')or(Info.Name='..')or(Info.Name=''))Then Begin
     SetAttributFiles(SetPath4AddFile(Path2Dir(FileSpec)+Info.Name)+'*.*');
    End;
   End;
  End
   Else
  Begin
   Assign(CurrFile,Path2Dir(FileSpec)+Info.Name);
   SetAttribut(CurrFile);
   If(ShowChanged)Then Begin
    If CurrAttr and ReadOnly=ReadOnly Then WriteLn('r')
                                       Else WriteLn(' ');
   End;
  End;
  FindNext(Info);
 End;
 If Not Found Then WriteLn('Aucun resultat trouve');
End;

Procedure ShowAttribut;
Var
 Info:SearchRec;
Begin
 FindFirst('*.*',AnyFile and Not Directory,Info);
 While DOSError=0 do Begin
  If Info.Attr and ReadOnly=ReadOnly Then Write('r') Else Write('-');
  If Info.Attr and SysFile=SysFile Then Write('s') Else Write('-');
  If Info.Attr and Archive=Archive Then Write('a') Else Write('-');
  If Info.Attr and Hidden=Hidden Then Write('h') Else Write('-');
  If Info.Attr and VolumeID=VolumeID Then Write('v') Else Write('-');
  If Info.Attr and Directory=Directory Then Write('d') Else Write('-');
  Write(' ');
  WriteLn(Info.Name);
  FindNext(Info);
 End;
End;

BEGIN
 Language:=_French;
 TmpLanguage:=GetEnv('LANGUAGE');
 If TmpLanguage<>''Then Begin
  If TmpLanguage[1]='"'Then TmpLanguage:=Copy(TmpLanguage,2,255);
  If StrToUpper(Copy(TmpLanguage,1,2))='EN'Then Language:=_English Else
  If StrToUpper(Copy(TmpLanguage,1,2))='GR'Then Language:=_Germany Else
  If StrToUpper(Copy(TmpLanguage,1,2))='IT'Then Language:=_Italian Else
  If StrToUpper(Copy(TmpLanguage,1,2))='SP'Then Language:=_Spain;
 End;
 If ParamStr(1)='/?'Then Begin
  Case Language of
   _English:Begin
    WriteLn('ATTR - This command allow to request or change the attribute of a file.');
    WriteLn;
    WriteLn('Syntax: ATTR filename [r|-r]');
    WriteLn;
    WriteLn(' -r   Clear read only attribut');
    WriteLn(' r    Set read only attribut');
   End;
   _Germany:Begin
    WriteLn('ATTR - Zeigt Dateiattribute an oder „ndert sie.');
    WriteLn;
    WriteLn('ATTR [r|-r] [[Laufwerk:][Pfad]Dateiname]');
    WriteLn;
    WriteLn(' -  L”scht ein Attribut.');
    WriteLn(' r  Attribut fr ''Schreibgeschtzte Datei''');
   End;
   Else Begin
    WriteLn('ATTR - Cette commande permet de demander ou changer l''attribut d''un fichier');
    WriteLn;
    WriteLn('Syntaxe : ATTR nomdufichier [r|-r] [-a]');
    WriteLn;
    WriteLn(' -r   Enleve de l''attribut de lecture seulement');
    WriteLn(' r    Ajout de l''attribut de lecture seulement');
    WriteLn;
    WriteLn(' -a   N''affiche pas le changement');
   End;
  End;
 End
  Else
 If ParamCount=0Then ShowAttribut
  Else
 If ParamCount>0Then Begin
  ShowChanged:=True;
  FillChar(IsAttrSetting,SizeOf(IsAttrSetting),0);
  AttrAdd:=0;
  AttrRemove:=0;
  SubDirectory:=False;
  For I:=1to ParamCount do Begin
   If StrToUpper(ParamStr(I))='R'Then Begin
    AttrAdd:=ReadOnly;
    IsAttrSetting[I]:=True;
   End
    Else
   If StrToUpper(ParamStr(I))='-R'Then Begin
    AttrRemove:=ReadOnly;
    IsAttrSetting[I]:=True;
   End
    Else
   If StrToUpper(ParamStr(I))='-A'Then Begin
    ShowChanged:=False;
    IsAttrSetting[I]:=True;
   End;
  End;
  For I:=1to ParamCount do Begin
   If Not IsAttrSetting[I]Then Begin
    SetAttributFiles(ParamStr(I));
   End;
   If I=255Then Exit;
  End;
 End;
END.
