-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/game/flynuo/FamilytpflynuoitemgetView.lua

module("logic.extensions.familyteamplay.view.game.flynuo.FamilytpflynuoitemgetView", package.seeall)

local FamilytpflynuoitemgetView = class("FamilytpflynuoitemgetView", ViewComponent)

function FamilytpflynuoitemgetView:ctor()
	FamilytpflynuoitemgetView.super.ctor(self)
end

function FamilytpflynuoitemgetView:buildUI()
	FamilytpflynuoitemgetView.super.buildUI(self)

	self._scoreText = goutil.findChildTextComponent(self.mainGO, "container/goodsCon/scoreText")
	self._itemConGo = self:getGo("container/goodsCon/itemCon")
	self._cellGo = self:getGo("container/goodsCon/itemCon/cell")
	self._itemGroup = ItemGroup.New(self._itemConGo, self._cellGo, nil, nil, true)
	self._closeBtn = self:getBtn("container/btnClose")
end

function FamilytpflynuoitemgetView:bindEvents()
	FamilytpflynuoitemgetView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function FamilytpflynuoitemgetView:unbindEvents()
	FamilytpflynuoitemgetView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function FamilytpflynuoitemgetView:destroyUI()
	FamilytpflynuoitemgetView.super.destroyUI(self)
end

function FamilytpflynuoitemgetView:onEnter()
	FamilytpflynuoitemgetView.super.onEnter(self)
	self:_updateView()
end

function FamilytpflynuoitemgetView:onEnterFinished()
	FamilytpflynuoitemgetView.super.onEnterFinished(self)
end

function FamilytpflynuoitemgetView:onExit()
	FamilytpflynuoitemgetView.super.onExit(self)
	self._itemGroup:dispose(function(item)
		MaterialMgr.resetAll(item.mainGO)
	end)
end

function FamilytpflynuoitemgetView:onExitFinished()
	FamilytpflynuoitemgetView.super.onExitFinished(self)
end

function FamilytpflynuoitemgetView:_updateView()
	self._scoreText.text = FamilyteamplayModel.instance:getFlynuoScoreInTemp()

	local params = self:getOpenParam()
	local changeSetId = params[2]
	local items = MaterialController.instance:getTempItemsByChangeSetId(changeSetId)

	self._itemGroup:updateWithMoArray(items, function(item, mo)
		MaterialMgr.setCellByMo(mo, item.mainGO)
	end)
end

return FamilytpflynuoitemgetView
