-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/data/DivineMiZongClgBuffTag.lua

module("logic.extensions.divinemizongclg.data.DivineMiZongClgBuffTag", package.seeall)

local DivineMiZongClgBuffTag = class("DivineMiZongClgBuffTag", CustomRightCell)

DivineMiZongClgBuffTag.prefabUrl = "ui/views/divinemizongclg/divinemizongclgbufftag.prefab"

function DivineMiZongClgBuffTag:buildUI()
	DivineMiZongClgBuffTag.super.buildUI(self)

	self._tagGo = goutil.findChild(self.mainGO, "tagGo")
end

function DivineMiZongClgBuffTag:setTagGoVisible(isVisible)
	GameUtil.SetActive(self._tagGo, isVisible)
end

return DivineMiZongClgBuffTag
