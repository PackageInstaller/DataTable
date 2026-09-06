-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat2023/view/YearCardPreheat2023ExploreView.lua

module("logic.extensions.yearcardpreheat2023.view.YearCardPreheat2023ExploreView", package.seeall)

local YearCardPreheat2023ExploreView = class("YearCardPreheat2023ExploreView", ViewComponent)

function YearCardPreheat2023ExploreView:buildUI()
	YearCardPreheat2023ExploreView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._conList = {}

	for i = 1, 4 do
		local cell = {}

		cell.go = self:getGo("conList/con_" .. i)
		cell.cover = goutil.findChild(cell.go, "cover")
		cell.btnGoto = goutil.findChild(cell.cover, "btnGoto")
		self._conList[i] = cell
	end
end

function YearCardPreheat2023ExploreView:bindEvents()
	YearCardPreheat2023ExploreView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)

	for i, v in ipairs(self._conList) do
		GameUtil.addClickHandler(v.btnGoto, GameUtil.handler(self._onClickGoto, self, i))
	end
end

function YearCardPreheat2023ExploreView:unbindEvents()
	YearCardPreheat2023ExploreView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i, v in ipairs(self._conList) do
		GameUtil.rmClickHandler(v.btnGoto)
	end
end

function YearCardPreheat2023ExploreView:onEnter()
	YearCardPreheat2023ExploreView.super.onEnter(self)

	self._actId = YearCardPreheat2023Model.instance:getActId()
	self._designId = YearCardPreheat2023Model.instance:getCurDesignId()

	for i, v in ipairs(self._conList) do
		goutil.setActive(v.cover, i >= self._designId)
	end

	local path = "20221223/zhaohuanmiyu/fx_ui_zhaohuanmiyu_yun.prefab"

	self._eff = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, false, nil, nil, function(finishHandlerTarget, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(1)
		eff:setLocalPos(0, 0, 0)
	end)

	if self._designId > 4 then
		path = "20221223/zhaohuanmiyu/fx_ui_zhaohuanmiyu_jm2.prefab"
		self._jmEff = UIEffectManager.instance:playEffect(self, "20221223/zhaohuanmiyu/fx_ui_zhaohuanmiyu_jm2.prefab", nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
			eff:setParent(self.mainGO.transform)
			eff:setScale(1)
			eff:setLocalPos(0, 0, 0)
		end)
	end
end

function YearCardPreheat2023ExploreView:onExit()
	YearCardPreheat2023ExploreView.super.onExit(self)

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end

	if self._jmEff then
		UIEffectManager.instance:stopEffect(self._jmEff)

		self._jmEff = nil
	end
end

function YearCardPreheat2023ExploreView:_onClickGoto(id)
	if id == self._designId then
		UIStateManager.instance:push(ViewName.YearCardPreheat2023GameView)
		self:close()
	else
		FloatWordMgr.instance:show(lang("请先探索前一区域后，再来探索本区域哦"))
	end
end

function YearCardPreheat2023ExploreView:_onClickClose()
	if self._designId > 4 then
		UIStateManager.instance:popByName(ViewName.YearCardPreheat2023GameView)
		UIStateManager.instance:push(ViewName.YearCardPreheat2023View, self._actId)
	else
		UIStateManager.instance:push(ViewName.YearCardPreheat2023GameView)
	end

	self:close()
end

return YearCardPreheat2023ExploreView
