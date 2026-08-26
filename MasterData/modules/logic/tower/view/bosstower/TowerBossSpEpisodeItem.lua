-- chunkname: @modules/logic/tower/view/bosstower/TowerBossSpEpisodeItem.lua

module("modules.logic.tower.view.bosstower.TowerBossSpEpisodeItem", package.seeall)

local TowerBossSpEpisodeItem = class("TowerBossSpEpisodeItem", LuaCompBase)

function TowerBossSpEpisodeItem:init(go)
	self.viewGO = go
	self.transform = go.transform
	self.goOpen = gohelper.findChild(self.viewGO, "goOpen")
	self.goUnopen = gohelper.findChild(self.viewGO, "goUnopen")
	self.goSelect1 = gohelper.findChild(self.viewGO, "goOpen/goSelect")
	self.goSelect2 = gohelper.findChild(self.viewGO, "goOpen/goSelect2")
	self.txtCurEpisode = gohelper.findChildTextMesh(self.viewGO, "goOpen/txtCurEpisode")
	self.goLock = gohelper.findChild(self.viewGO, "goOpen/goLock")
	self.goFinish = gohelper.findChild(self.viewGO, "goOpen/goFinished")
	self.animHasGet = gohelper.findChild(self.viewGO, "goOpen/goFinished/go_hasget"):GetComponent(gohelper.Type_Animator)
	self.btnClick = gohelper.findButtonWithAudio(self.viewGO)
	self.towerType = TowerEnum.TowerType.Boss
end

function TowerBossSpEpisodeItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self._onBtnClick, self)
end

function TowerBossSpEpisodeItem:removeEventListeners()
	self:removeClickCb(self.btnClick)
end

function TowerBossSpEpisodeItem:_onBtnClick()
	self.parentView:onClickEpisode(self.layerId)
end

function TowerBossSpEpisodeItem:updateItem(layerId, index, parentView)
	self.parentView = parentView
	self.layerId = layerId
	self.index = index

	if not layerId then
		gohelper.setActive(self.goUnopen, true)
		gohelper.setActive(self.goOpen, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	local towerMo = self.parentView.towerMo
	local episodeMo = self.parentView.episodeMo
	local isOpen = towerMo:isSpLayerOpen(self.layerId)

	gohelper.setActive(self.goUnopen, not isOpen)
	gohelper.setActive(self.goOpen, isOpen)

	if isOpen then
		self.txtCurEpisode.text = tostring(index)

		local isUnlock = towerMo:isLayerUnlock(self.layerId, episodeMo)

		gohelper.setActive(self.goLock, not isUnlock)
		self:updateSelect()
	end

	self.isPassLayer = towerMo.passLayerId >= self.layerId

	gohelper.setActive(self.goFinish, self.isPassLayer)
	self:playFinishEffect()
end

function TowerBossSpEpisodeItem:updateSelect()
	if not self.layerId then
		return
	end

	local isSelect = self.parentView:isSelectEpisode(self.layerId)

	gohelper.setActive(self.goSelect1, isSelect)
	gohelper.setActive(self.goSelect2, isSelect)

	local scale = isSelect and 1 or 0.85

	transformhelper.setLocalScale(self.transform, scale, scale, 1)
end

function TowerBossSpEpisodeItem:playFinishEffect()
	local openInfoMO = TowerModel.instance:getTowerOpenInfo(self.parentView.towerMo.type, self.parentView.towerMo.towerId)
	local saveFinishEffectState = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.TowerBossSPEpisodeFinishEffect, self.layerId, openInfoMO, 0)

	if saveFinishEffectState == 0 and self.isPassLayer then
		self.animHasGet:Play("go_hasget_in", 0, 0)
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.TowerBossSPEpisodeFinishEffect, self.layerId, openInfoMO, 1)
	else
		self.animHasGet:Play("go_hasget_idle", 0, 0)
	end
end

function TowerBossSpEpisodeItem:onDestroy()
	return
end

return TowerBossSpEpisodeItem
