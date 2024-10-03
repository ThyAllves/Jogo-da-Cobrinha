programa
{
	inclua biblioteca Sons --> sm
	inclua biblioteca Teclado --> t
	inclua biblioteca Util --> u
	inclua biblioteca Graficos --> g

	const inteiro LARGURA_JANELA = 600
	const inteiro ALTURA_JANELA = 600

     inteiro som_impacto = -1, musica_jogo = -1
	inteiro rep_musica_jogo = -1
	logico musica=verdadeiro
	
	inteiro pontuacao = 0
	inteiro xcabeca_cobra = 275
	inteiro ycabeca_cobra = 275
	inteiro tamanho_cobra = 2

	inteiro xcauda_cobra[600]
	inteiro ycauda_cobra[600]

	inteiro xposicoes_comida[24] =
	{0,25,50,75,100,125,150,175,200,225,250,275,300,325,350,375,
	400,425,450,475,500,525,550,575}

	inteiro yposicoes_comida[22] = {50,75,100,125,150,175,200,225,250,275,300,
	325,350,375,400,425,450,475,500,525,550,575}

	inteiro xcomida = 300
	inteiro ycomida = 300

	inteiro delay = 110
	
	
	logico direita=falso, esquerda=falso, para_cima=falso, para_baixo=falso

	inteiro tempo_inicio=0, tempo_decorrido=0, tempo_quadro=0, tempo_restante=0, frames=0, tempo_fps=0, tempo_inicio_fps=0, fps=0
	const inteiro TAXA_ATUALIZACAO=120 
	
	funcao inicio()
	{
		montar_janela()
		enquanto(verdadeiro){
			pintar_janela()
			desenhar_painel()
			direcionar_cobra()
			atualizar_posicoes_cobra()
			mover_cobra()
			atualizar_pontuacao()
			reiniciar()
			desenhar_comida()
			desenhar_cabeca_cobra()
			desenhar_cauda_cobra()
			sortear_posicao_comida()
			g.renderizar()
			atualizar_fps()
			u.aguarde(delay)		
	 }
	}
	
	funcao montar_janela(){
	 g.iniciar_modo_grafico(verdadeiro)
	 g.definir_dimensoes_janela(LARGURA_JANELA, ALTURA_JANELA)
	 g.definir_titulo_janela("Joguinho do Thiago")
	 }

	 funcao pintar_janela(){
	 	g.definir_cor(g.COR_BRANCO)
	 	g.limpar()
	 	
	 	}
	 funcao desenhar_painel(){
	 	g.definir_cor(g.COR_AZUL)
	 	g.desenhar_retangulo(0, 0, LARGURA_JANELA, 50, falso, verdadeiro)
	 	g.definir_cor(g.COR_AMARELO)
	 	g.definir_tamanho_texto(25.0)
	 	g.desenhar_texto(10, 10, "Pontuação atual: " + pontuacao)
	 	}

	 funcao carregar_sons()
	{
		som_impacto = sm.carregar_som(".Downloads/collect-points-190037.mp3")
		musica_jogo = sm.carregar_som(".Downloads/8-bit-arcade-mode-158814.mp3")
	}

	 funcao desenhar_cabeca_cobra(){
	 	g.definir_cor(g.COR_VERDE)
	 	g.desenhar_retangulo(xcabeca_cobra, ycabeca_cobra, 25, 25, verdadeiro, verdadeiro)
	 	}

	 funcao direcionar_cobra(){
	 	se(t.tecla_pressionada(t.TECLA_W)){
	        para_baixo = falso
	 	   para_cima = verdadeiro
	        esquerda = falso
	 	   direita = falso}
	 			
	 senao se(t.tecla_pressionada(t.TECLA_S)){
	 	   para_baixo = verdadeiro
	 	   para_cima = falso
	        esquerda = falso
	 	   direita = falso}
      senao se(t.tecla_pressionada(t.TECLA_A)){
             para_baixo = falso
	 	   para_cima = falso
	        esquerda = verdadeiro
	 	   direita = falso
          	}
      senao se(t.tecla_pressionada(t.TECLA_D)){
             para_baixo = falso
	 	   para_cima = falso
	        esquerda = falso
	 	   direita = verdadeiro
          	}	
	 	}
	 		
	 funcao mover_cobra(){
	 	se(direita){
	 		xcabeca_cobra += 25
	 		}
         senao se(esquerda){
	 		xcabeca_cobra -= 25
	 		}
         senao se(para_cima){
	 		ycabeca_cobra -= 25
	 		}	
         senao se(para_baixo)
	 		ycabeca_cobra += 25
	 }	
	 	

	 funcao logico cobra_bateu_parede(){
	 	
	 	se(xcabeca_cobra > 575 ou xcabeca_cobra < 0){
	 	 retorne verdadeiro}
	 	 
	 	senao se(ycabeca_cobra > 575 ou ycabeca_cobra < 50){
	 	 retorne verdadeiro}
	 		
	 	senao {
	 	 retorne falso}
	 	}	

	 funcao reiniciar(){
	 	se(cobra_bateu_parede() ou cobra_se_mordeu()){
	 	   tamanho_cobra = 2
	 	   xcabeca_cobra = 275
	 	   ycabeca_cobra = 275
	 	   para_baixo = falso
	 	   para_cima = falso
	        esquerda = falso
	 	   direita = falso
	 	   }
	 	  
	 	 }	
	 funcao logico cobra_comeu_comida() {
        se (xcabeca_cobra == xcomida e ycabeca_cobra == ycomida){
         retorne verdadeiro
       }senao{
         retorne falso
      }
}

     funcao sortear_posicao_comida(){
     	inteiro xindice = u.sorteia(0, 23)
     	inteiro yindice = u.sorteia(0, 21)
     	se(cobra_comeu_comida()){
     		xcomida = xposicoes_comida[xindice]
     		ycomida = yposicoes_comida[yindice]
     		}
     	}
     funcao desenhar_comida(){
     	g.definir_cor(g.COR_VERMELHO)
     	g.desenhar_elipse(xcomida, ycomida, 20, 20, verdadeiro)
     	}
     	
     funcao atualizar_posicoes_cobra(){
     	xcauda_cobra[0] = xcabeca_cobra
     	ycauda_cobra[0] = ycabeca_cobra
     	para(inteiro i = 599; i > 0; i--){
     		xcauda_cobra[i] = xcauda_cobra[i-1]
     		ycauda_cobra[i] = ycauda_cobra[i-1]
     		}
     	}

     funcao desenhar_cauda_cobra(){
     	se(cobra_comeu_comida()){
     		tamanho_cobra++
     		}
     	para(inteiro i = 0; i < tamanho_cobra; i++) 
     	 g.desenhar_retangulo(xcauda_cobra[i], ycauda_cobra[i], 25, 25, falso, verdadeiro)	
     	} 

     funcao atualizar_fps()
	{
		frames = frames + 1
		tempo_fps = u.tempo_decorrido() - tempo_inicio_fps

		se (tempo_fps >= 1000)
		{
			fps = frames
			tempo_inicio_fps = u.tempo_decorrido() - (tempo_fps - 1000)
			frames = 0
		}
	}	

     funcao atualizar_pontuacao(){
     	pontuacao = tamanho_cobra - 2
     	}

     funcao logico cobra_se_mordeu(){
     	logico mordeu = falso
     	para(inteiro i = 0; i < tamanho_cobra; i ++){
     		se(xcabeca_cobra == xcauda_cobra[i] e ycabeca_cobra == ycauda_cobra[i]){
     			mordeu = verdadeiro
     			}
     		}
     		retorne mordeu
     	}	
     				
	 	 			
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 3719; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */