@REM   ************************************************************************************
@REM   * decode.bat by Federico 'Secco' Mercatali                         VERSIONE: 0.90a *
@REM   *                                                                                  *
@REM   * DATA CREAZIONE: 10.06.2013 - ULTIMA MODIFICA: 20.06.2013                         *
@REM   * DESCRIZIONE: PP-IT, decodifica modulo pirata da certificare                      * 
@REM   *                                                                                  *
@REM   * AVVERTENZA: Ricordati di settare il tuo indirizzo email di certificatore (sotto) *
@REM   ************************************************************************************

@SET PP_CERTIFICATORE=f.mercatali@gmail.com 

@echo off
cls
echo.
echo  ----------------------------------------
echo   PP-IT decodifica modulo certificazione
echo  ----------------------------------------
echo.

REM controlla se e' stato passato il parametro, altrimenti assegnalo di default
 
IF "%1" == "" (SET MODULOSCARICATO=transfer.cgi) ELSE (SET MODULOSCARICATO=%1)

REM vedi che il file esista, senno' c'e' poco da fare

IF NOT EXIST "%MODULOSCARICATO%" (
   echo  ERRORE: Modulo da decodificare "%MODULOSCARICATO%" non trovato
   EXIT /B)

REM cancella eventuali file di output precedenti

IF EXIST modulo.html DEL modulo.html
IF EXIST modulo_iscrizione_signed DEL modulo_iscrizione_signed

REM decodifica il modulo ed aprilo in explorer

gpg --output modulo_iscrizione_signed -u %PP_CERTIFICATORE% --armor --detach-sign %MODULOSCARICATO% 
gpg --decrypt %MODULOSCARICATO% > modulo.html

EXPLORER modulo.html

echo.
echo  -----------------------------------
echo   Procedura di decodifica terminata 
echo  -----------------------------------
echo.
