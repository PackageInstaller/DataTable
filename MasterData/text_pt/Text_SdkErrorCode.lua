__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_SdkErrorCode = readonly({
  SdkErrorCode_67975_Content = {
    Text = "Erro de leitura/gravação do arquivo. Por favor, tente reiniciar o jogo ou reparar o cliente."
  },
  SdkErrorCode_67988_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_67989_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_67990_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_67991_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_67992_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_67993_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_67994_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68020_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68022_Content = {
    Text = "Exceção no download do arquivo, verifique o espaço disponível no dispositivo"
  },
  SdkErrorCode_68023_Content = {
    Text = "Conexão de rede ruim. Verifique sua rede e tente novamente."
  },
  SdkErrorCode_68024_Content = {
    Text = "Sem conexão com a rede, por favor, verifique a conexão e tente novamente"
  },
  SdkErrorCode_68027_Content = {
    Text = "Sem conexão com a rede, por favor, verifique a conexão e tente novamente"
  },
  SdkErrorCode_68033_Content = {
    Text = "Erro de leitura/gravação do arquivo. Por favor, tente reiniciar o jogo."
  },
  SdkErrorCode_68035_Content = {
    Text = "Erro de leitura/gravação do arquivo. Por favor, tente reiniciar o jogo."
  },
  SdkErrorCode_68037_Content = {
    Text = "Se o jogo chamar a interface de aquisição múltiplas vezes em um curto período, há uma certa probabilidade de obter um dos ejoy_tokens inválidos (os 16 tokens se sobreporão). Tentar entrar no servidor do jogo com tal token resultará em um erro 401."
  },
  SdkErrorCode_68058_Content = {
    Text = "Erro de leitura/gravação do arquivo. Por favor, tente reiniciar o jogo ou verificar as permissões do aplicativo."
  },
  SdkErrorCode_68060_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68061_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68062_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68063_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68064_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68065_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68066_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68067_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68068_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68069_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68071_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68072_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68073_Content = {
    Text = "Erro de leitura/gravação do arquivo. Por favor, tente reiniciar o jogo."
  },
  SdkErrorCode_68077_Content = {
    Text = "Erro de leitura de cache. Por favor, tente reiniciar o jogo."
  },
  SdkErrorCode_68078_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68082_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68100_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68109_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68110_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68111_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68112_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68113_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68114_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68115_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68116_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68118_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68119_Content = {
    Text = "Erro de leitura/gravação do arquivo. Por favor, tente reiniciar o jogo."
  },
  SdkErrorCode_68120_Content = {
    Text = "Erro de leitura/gravação do arquivo. Por favor, tente reiniciar o jogo."
  },
  SdkErrorCode_68121_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68133_Content = {
    Text = "Conexão de rede instável, por favor verifique a conexão ou reinicie o jogo e tente novamente"
  },
  SdkErrorCode_68153_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68158_Content = {
    Text = "Rede ocupada. Por favor, tente novamente mais tarde."
  },
  SdkErrorCode_68159_Content = {
    Text = "Exceção no download do arquivo, verifique o espaço disponível no dispositivo"
  },
  SdkErrorCode_68170_Content = {
    Text = "Rede ocupada. Por favor, tente novamente mais tarde."
  },
  SdkErrorCode_68173_Content = {
    Text = "Rede ocupada. Por favor, tente novamente mais tarde."
  },
  SdkErrorCode_68174_Content = {
    Text = "Rede ocupada. Por favor, tente novamente mais tarde."
  },
  SdkErrorCode_68175_Content = {
    Text = "Rede ocupada. Por favor, tente novamente mais tarde."
  },
  SdkErrorCode_68176_Content = {
    Text = "Sem conexão de rede. Por favor, verifique sua rede."
  },
  SdkErrorCode_68189_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68190_Content = {
    Text = "Conexão de rede anormal, por favor, tente reiniciar o jogo ou verificar a rede"
  },
  SdkErrorCode_68199_Content = {
    Text = "Conexão interrompida, por favor, verifique a rede"
  },
  SdkErrorCode_68201_Content = {
    Text = "Conexão interrompida, por favor, verifique a rede"
  },
  SdkErrorCode_68202_Content = {
    Text = "Erro de rede. Verifique sua rede."
  },
  SdkErrorCode_68205_Content = {
    Text = "Conexão interrompida, por favor, verifique a rede"
  },
  SdkErrorCode_68207_Content = {
    Text = "Conexão de rede interrompida. Verifique sua rede."
  },
  SdkErrorCode_68210_Content = {
    Text = "Erro de rede. Verifique sua rede."
  },
  SdkErrorCode_68235_Content = {
    Text = "Conexão de rede ruim. Verifique sua rede e tente novamente."
  },
  SdkErrorCode_68236_Content = {
    Text = "Sem conexão com a rede, por favor, verifique a conexão e tente novamente"
  },
  SdkErrorCode_68241_Content = {
    Text = "Conexão de rede ruim. Verifique sua rede e tente novamente."
  },
  SdkErrorCode_68245_Content = {
    Text = "Erro de conexão de rede. Verifique sua rede e tente novamente."
  },
  SdkErrorCode_68246_Content = {
    Text = "Conexão de rede ruim. Verifique sua rede e tente novamente."
  },
  SdkErrorCode_68248_Content = {
    Text = "Rede ocupada. Por favor, tente novamente mais tarde."
  },
  SdkErrorCode_68250_Content = {
    Text = "Exceção no download do arquivo, verifique o espaço disponível no dispositivo"
  },
  SdkErrorCode_68252_Content = {
    Text = "Erro ao baixar o arquivo. Por favor, reinicie o jogo ou repare o cliente."
  },
  SdkErrorCode_68261_Content = {
    Text = "Erro de leitura/gravação do arquivo. Por favor, tente reiniciar o jogo."
  },
  SdkErrorCode_68268_Content = {
    Text = "Conexão de rede instável, por favor verifique a conexão ou reinicie o jogo e tente novamente"
  },
  SdkErrorCode_68269_Content = {
    Text = "Conexão de rede instável, por favor verifique a conexão ou reinicie o jogo e tente novamente"
  },
  SdkErrorCode_68278_Content = {
    Text = "Erro de leitura/gravação do arquivo. Por favor, tente reiniciar o jogo ou reparar o cliente."
  }
})
return Text_SdkErrorCode
