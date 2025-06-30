-- chunkname: @IQIGame\\UIExternalApi\\StoryUIApi.lua

StoryUIApi = BaseLangApi:Extend()

function StoryUIApi:GetQuitTitleTips()
	return self:GetCfgText(7000013)
end

function StoryUIApi:GetQuitDescriptionTips()
	return self:GetCfgText(7000014)
end

function StoryUIApi:GetSpeakDialogueText(isAuto)
	return isAuto and self:GetCfgText(7000015) or self:GetCfgText(7000016)
end

function StoryUIApi:PlayPuzzleUIEnterSound()
	LuaUtility.PlaySoundWithID(22000167)
end

function StoryUIApi:PlayPuzzleUIOutSound()
	LuaUtility.PlaySoundWithID(22000006)
end

function StoryUIApi:PlayPuzzleUIConnectClickSound()
	LuaUtility.PlaySoundWithID(22000010)
end

function StoryUIApi:PlayPuzzleSuccessSound()
	LuaUtility.PlaySoundWithID(22000179)
end

function StoryUIApi:PlayPuzzleFailedSound()
	LuaUtility.PlaySoundWithID(22000180)
end

function StoryUIApi:PlayPuzzleUIConnectSuccessSound()
	LuaUtility.PlaySoundWithID(22000144)
end

function StoryUIApi:PlayPuzzleUISwitchTabSound()
	LuaUtility.PlaySoundWithID(22000168)
end

function StoryUIApi:PlayChatUIMessageShowSound()
	LuaUtility.PlaySoundWithID(22000112)
end

function StoryUIApi:PlayChatUISendSound()
	LuaUtility.PlaySoundWithID(22000100)
end

function StoryUIApi:CloseLvXiangEffectSound()
	LuaUtility.PlaySoundWithID(22000115)
end

function StoryUIApi:PlayCommonButtonSound()
	LuaUtility.PlaySoundWithID(10000001)
end

function StoryUIApi:PlaySelectPuzzleSound()
	LuaUtility.PlaySoundWithID(10000001)
end

function StoryUIApi:PlaySurveySound()
	LuaUtility.PlaySoundWithID(22000012)
end

function StoryUIApi:PlayDisplaySound()
	LuaUtility.PlaySoundWithID(22000128)
end

function StoryUIApi:PlayClickOptionSound()
	LuaUtility.PlaySoundWithID(22000115)
end
