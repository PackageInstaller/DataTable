-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/view/ThroneOneKeyLvUpView.lua

module("logic.extensions.throne.view.ThroneOneKeyLvUpView", package.seeall)

local ThroneOneKeyLvUpView = class("ThroneOneKeyLvUpView", ViewComponent)

function ThroneOneKeyLvUpView:ctor()
	ThroneOneKeyLvUpView.super.ctor(self)
end

function ThroneOneKeyLvUpView:unbindEvents()
	ThroneOneKeyLvUpView.super.unbindEvents(self)
end

function ThroneOneKeyLvUpView:bindEvents()
	ThroneOneKeyLvUpView.super.bindEvents(self)
end

function ThroneOneKeyLvUpView:buildUI()
	ThroneOneKeyLvUpView.super.buildUI(self)

	self._itemCon = self:getGo("itemCon")
	self._itemCell = self:getGo("itemCon/cell")
	self._itemGroup = ItemGroup.New(self._itemCon, self._itemCell, nil, nil, true)
end

function ThroneOneKeyLvUpView:onExit()
	ThroneOneKeyLvUpView.super.onExit(self)
end

function ThroneOneKeyLvUpView:onEnter()
	ThroneOneKeyLvUpView.super.onEnter(self)

	local changeAttrInfo = ThroneModel.instance:getTempChangeMap()
	local list = {}

	for name, info in pairs(changeAttrInfo) do
		table.insert(list, {
			name = langPara("全体%s", name),
			preTxt = info.oldAttr,
			lastTxt = info.newAttr
		})
	end

	self._itemGroup:updateWithMoArray(list, function(item, data)
		local nameText = goutil.findChildTextComponent(item.mainGO, "nameText")
		local preText = goutil.findChildTextComponent(item.mainGO, "preText")
		local lastText = goutil.findChildTextComponent(item.mainGO, "lastText")

		nameText.text = data.name
		preText.text = data.preTxt
		lastText.text = data.lastTxt
	end)
end

return ThroneOneKeyLvUpView
