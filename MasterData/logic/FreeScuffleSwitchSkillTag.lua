-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/data/FreeScuffleSwitchSkillTag.lua

module("logic.extensions.freescuffle.view.data.FreeScuffleSwitchSkillTag", package.seeall)

local FreeScuffleSwitchSkillTag = class("FreeScuffleSwitchSkillTag", CustomRightCell)

FreeScuffleSwitchSkillTag.prefabUrl = "ui/views/freescuffle/freescuffleswitchskilltag.prefab"

function FreeScuffleSwitchSkillTag:buildUI()
	self._tagSwitch = goutil.findChild(self.mainGO, "tagSwitch")
end

function FreeScuffleSwitchSkillTag:setTagSwitchUI(groupIdx)
	GameUtil.setUIGroupIdx(self._tagSwitch, groupIdx)
end

function FreeScuffleSwitchSkillTag:addClickHandler(callBack)
	GameUtil.addClickHandler(self._tagSwitch, callBack)
end

function FreeScuffleSwitchSkillTag:dispose()
	GameUtil.rmClickHandler(self._tagSwitch)
end

return FreeScuffleSwitchSkillTag
