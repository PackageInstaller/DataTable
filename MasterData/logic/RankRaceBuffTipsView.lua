-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceBuffTipsView.lua

module("logic.extensions.rankrace.view.RankRaceBuffTipsView", package.seeall)

local RankRaceBuffTipsView = class("RankRaceBuffTipsView", ViewComponent)

function RankRaceBuffTipsView:buildUI()
	RankRaceBuffTipsView.super.buildUI(self)

	self._imgBuffIcon = self:getGo("Icon")
	self._buffName = self:getTxt("TxtBuffName")
	self._buffDesc = self:getTxt("TxtBuffDesc")
	self._btnSeeAll = self:getBtn("BtnSeeAll")
	self._customInput = UICustomInput.Get(self.mainGO)
end

function RankRaceBuffTipsView:bindEvents()
	RankRaceBuffTipsView.super.bindEvents(self)
	self._btnSeeAll:AddClickListener(self._onClickBtnSeeAll, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function RankRaceBuffTipsView:unbindEvents()
	RankRaceBuffTipsView.super.unbindEvents(self)
	self._btnSeeAll:RemoveClickListener()
	self._customInput:RemoveListener()
end

function RankRaceBuffTipsView:onEnter()
	RankRaceBuffTipsView.super.onEnter(self)

	local openParams = self:getOpenParam()

	self._buffId = openParams[1]

	local posNode = openParams[2]

	self._matchType = openParams[3]
	self.mainGO.transform.position = posNode.transform.position

	local rect = goutil.findChildComponent(self.mainGO, "", "RectTransform")

	rect.anchoredPosition = Vector2(rect.anchoredPosition.x, 0)

	self:_updateBuff()
end

function RankRaceBuffTipsView:onExit()
	local bigImg = Framework.ImageBigBG.Get(self._imgBuffIcon)

	bigImg:ClearImage()

	self._buffId = nil
	self._matchType = nil

	RankRaceBuffTipsView.super.onExit(self)
end

function RankRaceBuffTipsView:_updateBuff()
	local buffCo = RankRaceConfig.instance:getRankRaceBuffCo(self._buffId)

	self._buffName.text = buffCo.name
	self._buffDesc.text = buffCo.desc

	uGuiUtil.setSpriteToImage(self._imgBuffIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceBuffIconUrl(buffCo.icon))
end

function RankRaceBuffTipsView:_onClickBtnSeeAll()
	ViewMgr.instance:open(ViewName.RankRaceAllBuffsView, self._matchType, self._buffId)
	self:close()
end

function RankRaceBuffTipsView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return RankRaceBuffTipsView
