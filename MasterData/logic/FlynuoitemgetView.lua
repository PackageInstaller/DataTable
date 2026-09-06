-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/FlynuoitemgetView.lua

module("logic.extensions.flyingnuo.view.FlynuoitemgetView", package.seeall)

local FlynuoitemgetView = class("FlynuoitemgetView", ViewComponent)

function FlynuoitemgetView:ctor()
	FlynuoitemgetView.super.ctor(self)
end

function FlynuoitemgetView:buildUI()
	FlynuoitemgetView.super.buildUI(self)

	self._scoreText = goutil.findChildTextComponent(self.mainGO, "container/goodsCon/scoreText")
	self._getDescText = goutil.findChildTextComponent(self.mainGO, "container/goodsCon/text")
	self._tipText = goutil.findChildTextComponent(self.mainGO, "container/tipText")
	self._itemCon = self:getGo("container/goodsCon/itemCon")
	self._itemCell = self:getGo("container/goodsCon/itemCon/cell")
	self._itemGroup = ItemGroup.New(self._itemCon, self._itemCell, nil, nil, true)
	self._closeBtn = self:getBtn("container/btnClose")
end

function FlynuoitemgetView:bindEvents()
	FlynuoitemgetView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function FlynuoitemgetView:unbindEvents()
	FlynuoitemgetView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function FlynuoitemgetView:destroyUI()
	FlynuoitemgetView.super.destroyUI(self)
end

function FlynuoitemgetView:onEnter()
	FlynuoitemgetView.super.onEnter(self)
	self:_updateView()
end

function FlynuoitemgetView:onEnterFinished()
	FlynuoitemgetView.super.onEnterFinished(self)
end

function FlynuoitemgetView:onExit()
	FlynuoitemgetView.super.onExit(self)
	self._itemGroup:dispose(function(item)
		MaterialMgr.resetAll(item.mainGO)
	end)
end

function FlynuoitemgetView:onExitFinished()
	FlynuoitemgetView.super.onExitFinished(self)
end

function FlynuoitemgetView:_updateView()
	local info = self:getFirstParam()
	local changeSetId = info.changeSetId
	local items = MaterialFacade.instance:getItemsByChangeSetId(changeSetId)
	local list = {}

	if items then
		for k, item in pairs(items) do
			local str = item.type .. ":" .. item.id .. ":" .. item.num

			table.insert(list, str)
		end
	end

	self._itemGroup:updateWithMoArray(list, function(item, str)
		MaterialMgr.setCellByCfg(str, item.mainGO)
	end)

	self._scoreText.text = info.curScore

	local preRank = FlyNuoModel.instance:getMyRank()
	local currRank = false

	if FlyNuoModel.instance:getEverMaxScore() < info.curScore and info.myRank > 0 then
		currRank = info.myRank
	end

	FlyNuoModel.instance:setEverMaxScore(info.everMaxScore)

	if currRank then
		self._tipText.text = "恭喜登上排行榜第" .. currRank .. "名" or ""
	end
end

return FlynuoitemgetView
