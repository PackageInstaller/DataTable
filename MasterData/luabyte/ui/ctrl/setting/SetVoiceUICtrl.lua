local SetVoiceUICtrl = BaseClass("SetVoiceUICtrl")

local M = SetVoiceUICtrl

function M:__init(view)
    self._view = view
    self._view.tg_backGroudSound:OnToggleClick(Bind(self, self.OnClickBackGroundSoundToggle))
    self._view.tg_sound:OnToggleClick(Bind(self, self.OnClickSoundToggle))
    self._view.tg_speech:OnToggleClick(Bind(self, self.OnClickSpeechToggle))

    self._view.slider_backGround:OnSliderChanged(Bind(self, self.OnBackGroudSoundSliderChanged))
    self._view.slider_sound:OnSliderChanged(Bind(self, self.OnSoundSliderChanged))
    self._view.slider_speech:OnSliderChanged(Bind(self, self.OnSpeechSliderChanged))
end

function M:Open()
    self._view.tg_backGroudSound:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Voice.BackGround,SettingDefault.Voice.BackGround)>0)
    self._view.tg_sound:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Voice.Sound,SettingDefault.Voice.Sound)>0)
    self._view.tg_speech:SetIsOn(GameHelper.GetPlayerPrefsInt(SettingConst.Voice.Speech,SettingDefault.Voice.Speech)>0)


    self._view.slider_backGround:SetValue(GameHelper.GetPlayerPrefsInt(SettingConst.Voice.BackgroundValue,SettingDefault.Voice.BackgroundValue) * 0.01)
    self._view.slider_sound:SetValue(GameHelper.GetPlayerPrefsInt(SettingConst.Voice.SoundValue,SettingDefault.Voice.SoundValue) * 0.01)
    self._view.slider_speech:SetValue(GameHelper.GetPlayerPrefsInt(SettingConst.Voice.SpeechValue,SettingDefault.Voice.SpeechValue) * 0.01)
end


function M:OnDispose()
    self._view.tg_backGroudSound:RemoveToggleAllClicks()
    self._view.tg_sound:RemoveToggleAllClicks()
    self._view.tg_speech:RemoveToggleAllClicks()
    self._view.slider_backGround:RemoveSliderListener()
    self._view.slider_sound:RemoveSliderListener()
    self._view.slider_speech:RemoveSliderListener()
    if self._view then
        self._view:OnDispose()
    end
    self._view = nil
end

function M:OnClickBackGroundSoundToggle(isOn)
    GameHelper.SetPlayerPrefsInt(SettingConst.Voice.BackGround,isOn and 1 or 0)
    ISettingDataMgr:SwitchMusicEnable(isOn)
end

function M:OnClickSoundToggle(isOn)
    GameHelper.SetPlayerPrefsInt(SettingConst.Voice.Sound,isOn and 1 or 0)
    ISettingDataMgr:SwitchSoundEnable(isOn)
end

function M:OnClickSpeechToggle(isOn)
    GameHelper.SetPlayerPrefsInt(SettingConst.Voice.Speech,isOn and 1 or 0)
    ISettingDataMgr:SwitchVoiceEnable(isOn)
end

function M:OnBackGroudSoundSliderChanged(value)
    self._view.slider_backGround:SetValue(value)
    local result = math.ceil(value*100);
    GameHelper.SetPlayerPrefsInt(SettingConst.Voice.BackgroundValue,result)
    ISettingDataMgr:SwitchMusicValue(result)
end

function M:OnSoundSliderChanged(value)
    self._view.slider_sound:SetValue(value)
    local result = math.ceil(value*100)
    GameHelper.SetPlayerPrefsInt(SettingConst.Voice.SoundValue,result)
    ISettingDataMgr:SwitchSoundValue(result)
end

function M:OnSpeechSliderChanged(value)
    self._view.slider_speech:SetValue(value)
    local result = math.ceil(value*100)
    GameHelper.SetPlayerPrefsInt(SettingConst.Voice.SpeechValue,result)
    ISettingDataMgr:SwitchVoiceValue(result)
end


function M:RevertAll(active)
    if active  then
        self._view.tg_backGroudSound:SetIsOn(SettingDefault.Voice.BackGround>0)
        self._view.tg_sound:SetIsOn(SettingDefault.Voice.Sound>0)
        self._view.tg_speech:SetIsOn(SettingDefault.Voice.Speech>0)
    else
        self:OnClickBackGroundSoundToggle(SettingDefault.Voice.BackGround>0)
        self:OnClickSoundToggle(SettingDefault.Voice.Sound>0)
        self:OnClickSpeechToggle(SettingDefault.Voice.Speech>0)
    end
    self:OnBackGroudSoundSliderChanged(SettingDefault.Voice.BackgroundValue)
    self:OnSoundSliderChanged(SettingDefault.Voice.SoundValue)
    self:OnSpeechSliderChanged(SettingDefault.Voice.SpeechValue)
end

return SetVoiceUICtrl
