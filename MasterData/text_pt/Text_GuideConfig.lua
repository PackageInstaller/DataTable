__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_GuideConfig = readonly({
  GuideConfig_10_Content_1 = {
    Text = "À frente, erguia-se um <RedQuality:enorme ser de seis asas prateadas>, irradiando um brilho deslumbrante"
  },
  GuideConfig_11_Content_1 = {
    Text = "Podemos confrontá-lo... ou eliminar as criaturas que rondam aqui e procurar o ponto de junção. É hora de você decidir, Guardião"
  },
  GuideConfig_12_Content_1 = {
    Text = "Mantenha a carta de comando pressionada e arraste para cima para emitir a ordem"
  },
  GuideConfig_13_Content_1 = {
    Text = "O inimigo está prestes a atacar causando dano fatal. Dê as instruções de defesa, guardião!"
  },
  GuideConfig_14_Content_1 = {
    Text = "Repetir o ataque com a Espada da Rainha torna a ofensiva mais feroz. Quer tentar terminar o oponente com esse movimento?"
  },
  GuideConfig_15_Content_1 = {
    Text = "Executar comandos de ataque gera loucura; quando a loucura estiver cheia, libera uma explosão de loucura poderosa"
  },
  GuideConfig_1_Content_1 = {
    Text = "Guardião do Segredo, agora você pode explorar adiante"
  },
  GuideConfig_2_Content_1 = {
    Text = "É o ponto de junção em mythag, a ressonância com a chave de prata pode restaurar a vida, é exatamente o que precisamos"
  },
  GuideConfig_34_Content_1 = {
    Text = "Atualmente, você está na fase de ensino de combate, ainda há cartas de comando que podem ser jogadas. Após completar o ensino, você pode jogar livremente"
  },
  GuideConfig_35_Content_1 = {
    Text = "Atualmente, você está na fase de ensino de combate, ainda há cartas de comando que podem ser jogadas. Após completar o ensino, você pode jogar livremente"
  },
  GuideConfig_36_Content_1 = {
    Text = "Atualmente, você está na fase de ensino de combate, ainda há cartas de comando que podem ser jogadas. Após completar o ensino, você pode jogar livremente"
  },
  GuideConfig_37_Content_1 = {
    Text = "Atualmente, você está na fase de ensino de combate, ainda há cartas de comando que podem ser jogadas. Após completar o ensino, você pode jogar livremente"
  },
  GuideConfig_38_Content_1 = {
    Text = "Atualmente, você está na fase de ensino de combate, ainda há explosões de loucura que podem ser usadas. Após completar o ensino, você pode jogar livremente"
  },
  GuideConfig_39_Content_1 = {
    Text = "Atualmente, você está na fase de ensino de combate, ainda há explosões de loucura que podem ser usadas. Após completar o ensino, você pode jogar livremente"
  },
  GuideConfig_3_Content_1 = {
    Text = "Derrote <RedQuality:a Baleia Enfurecida> rapidamente, não quero ver outra tragédia como a de antes"
  },
  GuideConfig_40_Content_1 = {
    Text = "Atualmente, você está na fase de ensino de combate, ainda há explosões de loucura que podem ser usadas. Após completar o ensino, você pode jogar livremente"
  },
  GuideConfig_41_Content_1 = {
    Text = "Atualmente, você está na fase de ensino de combate, ainda há explosões de loucura que podem ser usadas. Após completar o ensino, você pode jogar livremente"
  },
  GuideConfig_42_Content_1 = {
    Text = "Atualmente, você está na fase de ensino de combate, ainda há chaves que podem ser usadas. Após completar o ensino, você pode jogar livremente"
  },
  GuideConfig_47_Content_1 = {
    Text = "O Domínio do Caos tem uma forte Resonância com a Chave de prata, concedendo 250 de Energia de chave a cada turno para ajudar a Liberar sua Ordem de chave mais rápido. Se não houver Corpos Despertos de outros Domínios na sua equipe, você também receberá uma Criação de prata ao entrar na Fase. Use a Criação para ajudar a derrotar seus inimigos."
  },
  GuideConfig_47_TipsTitle_1 = {
    Text = "Domínio do Caos"
  },
  GuideConfig_49_Content_1 = {
    Text = "O Mar Profundo · Domínio gera 1 tentáculo no início da batalha. O tentáculo ataca o inimigo da linha de frente no final de cada turno. Corpos Despertos do Domínio do Mar Profundo podem fornecer vários reforços ao tentáculo. Você pode verificar o Dano de tentáculo atual pelo valor exibido abaixo do ícone do tentáculo."
  },
  GuideConfig_49_TipsTitle_1 = {
    Text = "Reino Aequor"
  },
  GuideConfig_4_Content_1 = {
    Text = "O sigilo negro pode ser sacrificado para o domínio <Yellow:marca de dissolução>, obtendo vários <Yellow:relíquias>, que são extremamente úteis em combate"
  },
  GuideConfig_55_Content_1 = {
    Text = "O Domínio de Carne e Sangue acumula Fusão de embriões e Forno Carmesim a cada turno—quanto menor sua Vida, mais rápido o acúmulo. Quando o Grau de Fusão de embriões atinge o limite, um embrião é gerado e colocado na sua Mão. Embriões podem ser usados diretamente para conceder Fúria e Taxa de Crítico Temporária ao Corpo Desperto correspondente; ou podem ser Devorados por um Corpo Desperto de Carne e Sangue via Fúria Explosiva para ativar Efeitos adicionais."
  },
  GuideConfig_55_TipsTitle_1 = {
    Text = "Domínio de Carne e Sangue"
  },
  GuideConfig_57_Content_1 = {
    Text = "Use o \"Forno Carmesim\" para Recuperar vida e resistir aos ataques!"
  },
  GuideConfig_58_Content_1 = {
    Text = "Quando um Corpo Desperto de Carne e Sangue libera Fúria Explosiva, ele pode Devorar embriões na sua Mão para Aumentar o Efeito de Fúria Explosiva. Libere Olho da Eternidade e ative Devorar!"
  },
  GuideConfig_5_Content_1 = {
    Text = "Descobri <Yellow:marca d>, coloque o sigilo negro que acumulou"
  },
  GuideConfig_60_Content_1 = {
    Text = "No Domínio Ultra, uma cópia Temporária da primeira Carta de comando Disparada a cada turno entra no Espaço Hiperdimensional. Quando o Espaço Hiperdimensional atinge seu limite, você pode entrar em um novo turno. Neste novo turno, você não vai Comprar carta; em vez disso, as Cartas do Espaço Hiperdimensional são colocadas na sua Mão."
  },
  GuideConfig_60_TipsTitle_1 = {
    Text = "Reino ultra"
  },
  GuideConfig_6_Content_1 = {
    Text = "Isso é <Yellow:relíquia>, originário do domínio, você sentirá seu poder em breve. Infelizmente, a relíquia se dissipa ao sair do domínio"
  },
  GuideConfig_7_Content_1 = {
    Text = "Parece haver um <Yellow:evento> repentino à frente, vá conferir. Talvez você possa obter um fortalecimento inesperado... embora às vezes venha com um custo"
  },
  GuideConfig_8_Content_1 = {
    Text = "Parece haver inimigos à frente"
  },
  GuideConfig_9_Content_1 = {
    Text = "Este é um corredor unidirecional, que deve levar ao salão subterrâneo, vamos, completar nossa missão"
  }
})
return Text_GuideConfig
