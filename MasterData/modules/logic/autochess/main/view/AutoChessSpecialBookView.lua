-- chunkname: @modules/logic/autochess/main/view/AutoChessSpecialBookView.lua

module("modules.logic.autochess.main.view.AutoChessSpecialBookView", package.seeall)

local AutoChessSpecialBookView = class("AutoChessSpecialBookView", BaseView)

function AutoChessSpecialBookView:onInitView()
	self._goView = gohelper.findChild(self.viewGO, "#go_View")
	self._scrollCard = gohelper.findChildScrollRect(self.viewGO, "#go_View/#scroll_Card")
	self._goCardRoot = gohelper.findChild(self.viewGO, "#go_View/#scroll_Card/Viewport/#go_CardRoot")
	self._goWarningContent = gohelper.findChild(self.viewGO, "#go_WarningContent")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

AutoChessSpecialBookView.Type = {
	Collection = 2,
	Leader = 1
}

function AutoChessSpecialBookView:_editableInitView()
	self.goScroll = self._scrollCard.gameObject
	self.actMo = Activity182Model.instance:getActMo()

	local goWarning = self:getResInst(AutoChessStrEnum.ResPath.WarningItem, self._goWarningContent)

	self.warningItem = MonoHelper.addNoUpdateLuaComOnceToGo(goWarning, AutoChessWarningItem)

	self.warningItem:refresh()

	self.mixDataList = {}
end

function AutoChessSpecialBookView:onOpen()
	local leaderCfgs = AutoChessConfig.instance:getSpecialLeaderCfgs()

	for _, config in ipairs(leaderCfgs) do
		self.mixDataList[#self.mixDataList + 1] = {
			type = AutoChessSpecialBookView.Type.Leader,
			id = config.id,
			unlockLvl = AutoChessConfig.instance:getLeaderUnlockLevel(config.id)
		}
	end

	local collectionCfgs = AutoChessConfig.instance:getSpecialCollectionCfgs()

	for _, config in ipairs(collectionCfgs) do
		self.mixDataList[#self.mixDataList + 1] = {
			type = AutoChessSpecialBookView.Type.Collection,
			id = config.id,
			unlockLvl = AutoChessConfig.instance:getCollectionUnlockLevel(config.id)
		}
	end

	table.sort(self.mixDataList, function(a, b)
		if a.unlockLvl == b.unlockLvl then
			if a.type == b.type then
				return a.id < b.id
			else
				return a.type < b.type
			end
		else
			return a.unlockLvl < b.unlockLvl
		end
	end)

	for k, data in ipairs(self.mixDataList) do
		local id = data.id

		if data.type == AutoChessSpecialBookView.Type.Leader then
			local goLeader = self:getResInst(AutoChessStrEnum.ResPath.LeaderCard, self._goCardRoot)
			local item = MonoHelper.addNoUpdateLuaComOnceToGo(goLeader, AutoChessLeaderCard)
			local param = {
				freshLock = true,
				leaderId = id,
				tipPos = Vector2(20, 20)
			}

			item:setData(param)
			item:refreshNewTag()
			item:setScrollParentGo(self.goScroll)
		elseif data.type == AutoChessSpecialBookView.Type.Collection then
			local goCollection = self:getResInst(AutoChessStrEnum.ResPath.CollectionItem, self._goCardRoot)
			local item = MonoHelper.addNoUpdateLuaComOnceToGo(goCollection, AutoChessCollectionItem)

			item:setData(id)
			item:refreshNewTag()
			item:setScrollParentGo(self.goScroll)
		end

		if not self.lockIndex and self.actMo.warnLevel < data.unlockLvl then
			self.lockIndex = k
		end
	end

	self._scrollCard.horizontalNormalizedPosition = 0

	TaskDispatcher.runDelay(self.delaySet, self, 0.3)
end

function AutoChessSpecialBookView:delaySet()
	if self.lockIndex and self.lockIndex > 2 then
		local itemWidth = 574
		local width = recthelper.getWidth(self._goCardRoot.transform)
		local diff = width - recthelper.getWidth(self._goCardRoot.transform.parent)
		local value = Mathf.Clamp((self.lockIndex - 2) * itemWidth / diff, 0, 1)

		self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, value, 0.4, self._frameCallback, nil, self, nil, EaseType.OutCirc)
	end
end

function AutoChessSpecialBookView:_frameCallback(value)
	self._scrollCard.horizontalNormalizedPosition = value
end

function AutoChessSpecialBookView:onDestroyView()
	local freshReddot = false

	for _, data in ipairs(self.mixDataList) do
		if self.actMo.warnLevel >= data.unlockLvl then
			local key = data.type == AutoChessSpecialBookView.Type.Leader and AutoChessStrEnum.ClientReddotKey.SpecialLeader or AutoChessStrEnum.ClientReddotKey.SpecialCollection
			local isShow = AutoChessHelper.getUnlockReddot(key, data.id)

			if isShow then
				AutoChessHelper.setUnlockReddot(key, data.id)

				freshReddot = true
			end
		end
	end

	if freshReddot then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.updateCultivateReddot)
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	TaskDispatcher.cancelTask(self.delaySet, self)
end

return AutoChessSpecialBookView
