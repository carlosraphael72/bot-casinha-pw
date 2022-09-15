#include <ImageSearch2015.au3>

HotKeySet("{F9}", "parar")

$caminho = "D:\LoginPw"

$iconeEscolher = "img\Escolher.png"
$iconeConfirmar = "img\Confirmar.png"
$iconeConfirmarPlanta = "img\confirmarPlanta.png"
$iconeCoordenadas = "img\coord.png"
$iconePegar = "img\pegar.png"
$iconePreencher = "img\preencher.png"
$iconeManual = "img\manual.png"
$iconeAceitar = "img\aceitar.png"
$iconeColecao = "img\colecao.png"
$iconeMissao = "img\missao.png"
$iconeCompletar = "img\completar.png"
$iconeBotaoCompletar = "img\botaoCompletar.png"
$iconeColetarRubis = "img\coletarRubis.png"
$iconeLateral = "img\lateral.png"
$iconeAbiu = "img\abiu.png"
$iconeCervo = "img\cervo.png"
$iconeJardinagem = "img\jardinagem.png"
$iconeQ = "img\q.png"

$corMissao = 0xEA6402
$corServidor = 0xFFCB4A

$left = 17
$top = 40
$right = 1175
$bottom = 686

login("WR")
Sleep(10000)
casinha()
missao()
Sleep(2000)
coordenadas()

Sleep(2000)

login("PL")
Sleep(10000)
casinha()
missao()
Sleep(2000)
coordenadas()

Sleep(2000)

login("RT")
Sleep(10000)
casinha()
missao()
Sleep(2000)
coordenadas()

Sleep(2000)

login("MC Gabriel")
Sleep(10000)
casinha()
missao()
Sleep(2000)
coordenadas()

MsgBox(0, "Aviso", "Acabou")

Func login($conta)
	$x = 0
	$y = 0
	$repetir = True

	Sleep(2000)
	ShellExecute($conta, "", $caminho)
	WinWait("Perfect World")
	While $repetir = True
		Sleep(10000)
		WinActivate("Perfect World")
		WinMove("Perfect World", "", 0, 0, 1192, 703)

		$servidor = PixelSearch($left, $top, $right, $bottom, $corServidor)

		If IsArray($servidor) Then
			MouseClick("LEFT", $servidor[0], $servidor[1], 2, 15)
			$repetir = False
		Else
			ToolTip("Servidor não encontrado", 0, 0)
			Sleep(2000)
			$repetir = True
		EndIf
	#cs
		$escolher = _ImageSearch($iconeEscolher, 1, $x, $y, 0, 0)
		If $escolher = 1 Then
			MouseClick("LEFT", $x, $y, 1, 15)
		Else
			ToolTip("Servidor não encontrado")
			Sleep(2000)
		EndIf
	#ce
	WEnd
EndFunc


Func casinha()
	$x = 0
	$y = 0
	$repetir = True
	$loop = True

	While $repetir = True
		Sleep(5000)
		$vida = PixelSearch($left, $top, $right, $bottom, 0xAF2C1F)
		if IsArray($vida) Then

			WinActivate("Perfect World")
			MouseClick("LEFT", 1087, 667)
			Sleep(1000)
			MouseClick("LEFT", 1050, 625)
			$repetir = False
			While $loop = True
				Sleep(10000)
				$q = _ImageSearch($iconeQ, 1, $x, $y, 50, 0)
				If $q = 1 Then
					Send("{S DOWN}")
					Sleep(500)
					Send("{S UP}")
					Sleep(2000)
					Send("{9}")
					Sleep(1000)
					$loop = False

				Else
					ToolTip("Esperando entrar na casinha", 0, 0)
					Sleep(2000)
					$loop = True
				EndIf
			WEnd
		Else
			ToolTip("Esperando logar", 0, 0)
			Sleep(2000)
			$repetir = True
		EndIf
	WEnd
	;Limpar a casa com rubis
	MouseClick("LEFT", 182, 76, 1, 15)
	Sleep(1000)
	$confirmar = _ImageSearch($iconeConfirmar, 1, $x, $y, 50, 0)
	If $confirmar = 1 Then
		MouseClick("LEFT", $x, $y, 1, 15)
		Sleep(1000)
		Send("{ESC}")
	Else
		ToolTip("Falha ao limpar a casa")
		Sleep(1000)
		Send("{ESC}")
	EndIf


EndFunc

Func coordenadas()
	$x = 0
	$y = 0
	$yMaterial = 157
	$yPlantacao = 100
	$yRancho = $yPlantacao + 18

	WinActivate("Perfect World")

	;Coleta de Rubi / Plantação e Rancho
	$coordenadas = _ImageSearch($iconeCoordenadas, 1, $x, $y, 80, 0)

	If $coordenadas = 1 Then
		MouseClick("LEFT", $x, $y, 1, 15)
		Sleep(1000)
		MouseClick("LEFT", 226, $yPlantacao, 2, 15)
		Sleep(2000)
		plantacao()
		Sleep(1000)
		MouseClick("LEFT", 226, $yRancho, 2, 15)
		Sleep(2000)
		rancho()
	Else

	EndIf

	;Coleta de materiais
	Sleep(500)
	For $i = 0 to 3 Step 1
	$result = _ImageSearch($iconeCoordenadas, 1, $x, $y, 80, 0)


	If $result = 1 Then
		MouseClick("LEFT", $x, $y, 1, 15)
		Sleep(1000)
		MouseClick("LEFT", 194, $yMaterial, 2, 15)
		Sleep(10000)
		materiais()
		$yMaterial = $yMaterial + 18
	Else
		MouseClick("LEFT", 194, $yMaterial, 2, 15)
		Sleep(10000)
		materiais()
		$yMaterial = $yMaterial + 18
	EndIf
	Next
	Send("{ESC}")
EndFunc

Func materiais()
	$x = 0
	$y = 0

	$repetir = True

	;Tentar clicar no material novamente caso erre o click
	While $repetir = True
	MouseClick("LEFT", 566, 295, 1, 15) ;clica no meio da tela
	Sleep(2500)
	$pegar = _ImageSearch($iconePegar, 1, $x, $y, 50, 0)
	If $pegar = 1 Then
		MouseClick("LEFT", $x, $y, 1, 15)
		$repetir = False
	Else
		ToolTip("Erro")
		Sleep(2000)
		$repetir = True
	EndIf
	Sleep(1000)
	$preencher = _ImageSearch($iconePreencher, 1, $x, $y, 50, 0)
	if $preencher = 1 Then
		MouseClick("LEFT", $x, $y, 1, 15)
		$repetir = False
	Else
		ToolTip("Erro")
		Sleep(2000)
		$repetir = True
	EndIf
	WEnd
	Sleep(1000)
	Send("{ESC}")
EndFunc

Func missao()
	$x = 0
	$y = 0

	WinActivate("Perfect World")
	;Abre interface de missões
	Sleep(2000)
	MouseClick("LEFT", 40, 137, 1, 15)
	Sleep(1000)
	;Missão de mobília

	$jardinagem = _ImageSearch($iconeJardinagem, 1, $x, $y, 50, 0)
	If $jardinagem = 1 Then
		MouseClick("LEFT", $x, $y, 1, 15)
		Sleep(500)
		Send("{DOWN}")
		aceitar()
		Sleep(5000)
		;Aceitar a missão mais alta da maestria
		$missao = _ImageSearch($iconeMissao, 1, $x, $y, 20, 0)
		If $missao = 1 Then
			MouseClick("LEFT", $x, $y, 1, 15)
			Sleep(1000)
			For $i = 0 to 10 Step 1
				Sleep(200)
				Send("{DOWN}")
			Next
			aceitar()
		Else
			ToolTip("Missão de maestria não encontrada")
			Sleep(2000)
			Exit
		EndIf

	Else
		ToolTip("Manual de mobilia não encontrado!")
		Sleep(2000)
		Exit
	EndIf

	Sleep(2000)
	;Clica na lista de missões
	$colecao = _ImageSearch($iconeColecao, 1, $x, $y, 20, 0)
	If $colecao = 1 Then
		MouseClick("LEFT", $x, $y, 1, 15)
	Else
		ToolTip("Coleção não encontrada")
		Sleep(2000)
		Exit
	EndIf

	Sleep(1000)
	;Escolher missão

	$missao = PixelSearch($left, $top, $right, $bottom, $corMissao)

	If IsArray($missao) Then
		MouseClick("LEFT", $missao[0], $missao[1], 1, 15)
		aceitar()
	Else
		ToolTip("Missão não encontrada")
		Sleep(1000)
		Exit
	EndIf

	Sleep(1000)
	;Completa missão de mobília
	$completar = _ImageSearch($iconeCompletar, 1, $x, $y, 50, 0)
	If $completar = 1 Then
		MouseClick("LEFT", $x, $y, 1, 15)
		Sleep(500)
		$missao = _ImageSearch($iconeMissao, 1, $x, $y, 20, 0)
		If $missao = 1 Then
			MouseClick("LEFT", $x, $y, 1, 15)
			Sleep(500)
			Send("{DOWN}")
			Sleep(500)
			$botaoCompletar = _ImageSearch($iconeBotaoCompletar, 1, $x, $y, 50, 0)
			If $botaoCompletar = 1 Then
				MouseClick("LEFT", $x, $y, 1, 15)
				Sleep(1000)
				MouseClick("LEFT", $x, $y, 1, 15)
				Sleep(500)
				Send("{ESC}")
				MouseMove(0, 0, 15)
			Else
				ToolTip("Botão não encontrado!")
				Sleep(2000)
				Exit
			EndIf
		Else
			ToolTip("Não foi possivel completar a missão")
			Sleep(2000)
			Exit
		EndIf
	Else
		ToolTip("Não foi possivel ir para aba de completar missões")
		Sleep(2000)
		Exit
	EndIf
	Sleep(1000)
	Send("{ESC}")
EndFunc

Func aceitar()
	$x = 0
	$y = 0
	Sleep(1000)
	$aceitar = _ImageSearch($iconeAceitar, 1, $x, $y, 80, 0)
	If $aceitar = 1 Then
		MouseClick("LEFT", $x, $y, 1, 15)

	Else
		ToolTip("Botão Aceitar não encontrado")
		Sleep(2000)
		Exit
	EndIf

EndFunc

Func plantacao()
	$x = 0
	$y = 0

	MouseClick("LEFT", 566, 295, 1, 15) ;clica no meio da tela
	Sleep(1000)
	$coletarRubis = _ImageSearch($iconeColetarRubis, 1, $x, $y, 20, 0)
	If $coletarRubis = 1 Then
		MouseClick("LEFT", $x, $y, 1, 15)
		Sleep(1000)
		$lateral = _ImageSearch($iconeLateral, 1, $x, $y, 20, 0)
		If $lateral = 1 Then
			$yLateral = $y + 375
			MouseClickDrag("LEFT", $x, $y, $x, $yLateral, 15)
			Sleep(1000)
			$abiu = _ImageSearch($iconeAbiu, 1, $x, $y, 20, 0)
			If $abiu = 1 Then
				MouseClick("LEFT", $x, $y, 1, 15)
				Sleep(500)
				$confirmarPlanta = _ImageSearch($iconeConfirmarPlanta, 1, $x, $y, 50, 0)
				If $confirmarPlanta = 1 Then
					MouseClick("LEFT", $x, $y, 1, 15)
					Sleep(1000)
					Send("{ESC}")
				Else
					ToolTip("Falha ao plantar")
					Sleep(1000)
					Exit
				EndIf
			Else

			EndIf
		Else
			ToolTip("Barra lateral não encontrada")
			Sleep(2000)
			Exit
		EndIf
	Else
		ToolTip("Não coletou os rubis")
		Sleep(2000)
		Exit
	EndIf
EndFunc

Func rancho()
	$x = 0
	$y = 0

	MouseClick("LEFT", 566, 295, 1, 15) ;clica no meio da tela
	Sleep(1000)
	$coletarRubis = _ImageSearch($iconeColetarRubis, 1, $x, $y, 20, 0)
	If $coletarRubis = 1 Then
		MouseClick("LEFT", $x, $y, 1, 15)
		Sleep(1000)
		$lateral = _ImageSearch($iconeLateral, 1, $x, $y, 20, 0)
		If $lateral = 1 Then
			$yLateral = $y + 375
			MouseClickDrag("LEFT", $x, $y, $x, $yLateral, 15)
			Sleep(1000)
			$cervo = _ImageSearch($iconeCervo, 1, $x, $y, 20, 0)
			If $cervo = 1 Then
				MouseClick("LEFT", $x, $y, 1, 15)
				Sleep(500)
				$confirmarPlanta = _ImageSearch($iconeConfirmarPlanta, 1, $x, $y, 50, 0)
				If $confirmarPlanta = 1 Then
					MouseClick("LEFT", $x, $y, 1, 15)
					Sleep(1000)
					Send("{ESC}")
				Else
					ToolTip("Falha ao plantar")
					Sleep(1000)
					Exit
				EndIf
			Else

			EndIf
		Else
			ToolTip("Barra lateral não encontrada")
			Sleep(2000)
			Exit
		EndIf
	Else
		ToolTip("Não coletou os rubis")
		Sleep(2000)
		Exit
	EndIf

EndFunc

Func parar()
	Exit


EndFunc