-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/FlynuorewardItem.lua

module("logic.extensions.flyingnuo.view.FlynuorewardItem", package.seeall)

local FlynuorewardItem = class("FlynuorewardItem")

function FlynuorewardItem:ctor(go)
	self.mainGO = go

	self:buildUI()
end

function FlynuorewardItem:OnDestroy()
	self:onExit()
end

function FlynuorewardItem:buildUI()
	self._rewardCon = goutil.findChild(self.mainGO, "reward")
	self._rewardCell = goutil.findChild(self.mainGO, "cell")
	self._itemGroup = ItemGroup.New(self._rewardCon, self._rewardCell, nil, nil, true)
	self._needScoreText = goutil.findChildTextComponent(self.mainGO, "text")
end

function FlynuorewardItem:onEnter(data, nextData)
	self._data = data
	self._nextData = nextData
	self._needScoreText.text = nextData and data.leftScore .. "~" .. nextData.leftScore - 1 or data.leftScore .. "以上"

	local list = string.split(data.prize, "#")

	self._itemGroup:updateWithMoArray(list, function(item, data)
		MaterialMgr.setCellByCfg(data, item.mainGO)
	end)
end

function FlynuorewardItem:onExit()
	self._itemGroup:dispose(function(item, data)
		MaterialMgr.resetAll(item.mainGO)
	end)
end

return FlynuorewardItem
