__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_SdkErrorCode = readonly({
  SdkErrorCode_67975_Content = {
    Text = "Error de lectura/escritura de archivo. Por favor, intente reiniciar el juego o reparar el cliente."
  },
  SdkErrorCode_67988_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_67989_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_67990_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_67991_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_67992_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_67993_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_67994_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68020_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68022_Content = {
    Text = "Error al descargar el archivo, por favor verifica el espacio disponible en el dispositivo"
  },
  SdkErrorCode_68023_Content = {
    Text = "Conexión de red deficiente. Por favor, revisa tu red y vuelve a intentarlo."
  },
  SdkErrorCode_68024_Content = {
    Text = "Sin conexión a internet, por favor verifique la red e inténtelo de nuevo"
  },
  SdkErrorCode_68027_Content = {
    Text = "Sin conexión a internet, por favor verifique la red e inténtelo de nuevo"
  },
  SdkErrorCode_68033_Content = {
    Text = "Error de lectura/escritura de archivo. Por favor, intente reiniciar el juego."
  },
  SdkErrorCode_68035_Content = {
    Text = "Error de lectura/escritura de archivo. Por favor, intente reiniciar el juego."
  },
  SdkErrorCode_68037_Content = {
    Text = "Si el juego llama a la interfaz de adquisición múltiples veces en un corto período, existe una cierta probabilidad de obtener uno de los ejoy_tokens inválidos (los 16 tokens se sobrescribirán entre sí). Intentar iniciar sesión en el servidor del juego con un token así resultará en un error 401."
  },
  SdkErrorCode_68058_Content = {
    Text = "Error de lectura/escritura de archivo. Por favor, intente reiniciar el juego o verificar los permisos de la aplicación."
  },
  SdkErrorCode_68060_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68061_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68062_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68063_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68064_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68065_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68066_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68067_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68068_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68069_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68071_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68072_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68073_Content = {
    Text = "Error de lectura/escritura de archivo. Por favor, intente reiniciar el juego."
  },
  SdkErrorCode_68077_Content = {
    Text = "Error de lectura de caché. Por favor, intenta reiniciar el juego."
  },
  SdkErrorCode_68078_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68082_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68100_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68109_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68110_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68111_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68112_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68113_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68114_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68115_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68116_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68118_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68119_Content = {
    Text = "Error de lectura/escritura de archivo. Por favor, intente reiniciar el juego."
  },
  SdkErrorCode_68120_Content = {
    Text = "Error de lectura/escritura de archivo. Por favor, intente reiniciar el juego."
  },
  SdkErrorCode_68121_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68133_Content = {
    Text = "Conexión de red deficiente, por favor revise la conexión o reinicie el juego e intente nuevamente"
  },
  SdkErrorCode_68153_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68158_Content = {
    Text = "Red ocupada. Por favor, inténtalo de nuevo más tarde."
  },
  SdkErrorCode_68159_Content = {
    Text = "Error al descargar el archivo, por favor verifica el espacio disponible en el dispositivo"
  },
  SdkErrorCode_68170_Content = {
    Text = "Red ocupada. Por favor, inténtalo de nuevo más tarde."
  },
  SdkErrorCode_68173_Content = {
    Text = "Red ocupada. Por favor, inténtalo de nuevo más tarde."
  },
  SdkErrorCode_68174_Content = {
    Text = "Red ocupada. Por favor, inténtalo de nuevo más tarde."
  },
  SdkErrorCode_68175_Content = {
    Text = "Red ocupada. Por favor, inténtalo de nuevo más tarde."
  },
  SdkErrorCode_68176_Content = {
    Text = "No hay conexión de red. Verifica tu red."
  },
  SdkErrorCode_68189_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68190_Content = {
    Text = "Conexión de red anormal, por favor intenta reiniciar el juego o verifica la red"
  },
  SdkErrorCode_68199_Content = {
    Text = "Conexión interrumpida, por favor verifica la red"
  },
  SdkErrorCode_68201_Content = {
    Text = "Conexión interrumpida, por favor verifica la red"
  },
  SdkErrorCode_68202_Content = {
    Text = "Error de red. Por favor, verifica tu red."
  },
  SdkErrorCode_68205_Content = {
    Text = "Conexión interrumpida, por favor verifica la red"
  },
  SdkErrorCode_68207_Content = {
    Text = "Conexión de red interrumpida. Por favor, verifica tu red."
  },
  SdkErrorCode_68210_Content = {
    Text = "Error de red. Por favor, verifica tu red."
  },
  SdkErrorCode_68235_Content = {
    Text = "Conexión de red deficiente. Por favor, revisa tu red y vuelve a intentarlo."
  },
  SdkErrorCode_68236_Content = {
    Text = "Sin conexión a internet, por favor verifique la red e inténtelo de nuevo"
  },
  SdkErrorCode_68241_Content = {
    Text = "Conexión de red deficiente. Por favor, revisa tu red y vuelve a intentarlo."
  },
  SdkErrorCode_68245_Content = {
    Text = "Error de conexión de red. Por favor, comprueba tu red e inténtalo de nuevo."
  },
  SdkErrorCode_68246_Content = {
    Text = "Conexión de red deficiente. Por favor, revisa tu red y vuelve a intentarlo."
  },
  SdkErrorCode_68248_Content = {
    Text = "Red ocupada. Por favor, inténtalo de nuevo más tarde."
  },
  SdkErrorCode_68250_Content = {
    Text = "Error al descargar el archivo, por favor verifica el espacio disponible en el dispositivo"
  },
  SdkErrorCode_68252_Content = {
    Text = "Error de descarga de archivo. Por favor, reinicie el juego o repare el cliente."
  },
  SdkErrorCode_68261_Content = {
    Text = "Error de lectura/escritura de archivo. Por favor, intente reiniciar el juego."
  },
  SdkErrorCode_68268_Content = {
    Text = "Conexión de red deficiente, por favor revise la conexión o reinicie el juego e intente nuevamente"
  },
  SdkErrorCode_68269_Content = {
    Text = "Conexión de red deficiente, por favor revise la conexión o reinicie el juego e intente nuevamente"
  },
  SdkErrorCode_68278_Content = {
    Text = "Error de lectura/escritura de archivo. Por favor, intente reiniciar el juego o reparar el cliente."
  }
})
return Text_SdkErrorCode
