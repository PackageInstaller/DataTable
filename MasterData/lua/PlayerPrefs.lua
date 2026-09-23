local this = {};

this.GetString = CS.UnityEngine.PlayerPrefs.GetString;
this.SetString = CS.UnityEngine.PlayerPrefs.SetString;
this.GetInt = CS.UnityEngine.PlayerPrefs.GetInt;
this.SetInt = CS.UnityEngine.PlayerPrefs.SetInt;
this.HasKey=CS.UnityEngine.PlayerPrefs.HasKey;
this.DeleteKey=CS.UnityEngine.PlayerPrefs.DeleteKey;
this.DeleteAll=CS.UnityEngine.PlayerPrefs.DeleteAll;
--this.GetFloat = CS.UnityEngine.PlayerPrefs.GetFloat;--用整形代替
--this.SetFloat = CS.UnityEngine.PlayerPrefs.SetFloat;

return this;