-- chunkname: @modules/logic/sodache/view/outside/comp/SodacheLevelItem.lua

module("modules.logic.sodache.view.outside.comp.SodacheLevelItem", package.seeall)

local SodacheLevelItem = class("SodacheLevelItem", LuaCompBase)

SodacheLevelItem.ScalerSelected = 1
SodacheLevelItem.ScalerSelectedAdjacent = 0.8
SodacheLevelItem.ScalerNormal = 0.8

function SodacheLevelItem:ctor(index)
	self.index = index
end

function SodacheLevelItem:init(go)
	self.transform = go.transform
	self.goLock = gohelper.findChild(go, "Lock")
	self.txtLevelL = gohelper.findChildText(go, "Lock/txt_Level")
	self.goUnlock = gohelper.findChild(go, "Unlock")
	self.imageProgressU = gohelper.findChildImage(go, "Unlock/image_ProgressU")
	self.txtLevelU = gohelper.findChildText(go, "Unlock/txt_Level")
	self.goSelect = gohelper.findChild(go, "Select")
	self.imageProgressS = gohelper.findChildImage(go, "Select/image_ProgressS")
	self.txtLevelS = gohelper.findChildText(go, "Select/txt_Level")

	local btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")

	self.addClickCb(self, btnClick, self._btnOnClick, self)

	self.matProgress = UnityEngine.Object.Instantiate(self.imageProgressS.material)
	self.imageProgressU.material = self.matProgress
	self.imageProgressS.material = self.matProgress
end

function SodacheLevelItem:onDestroy()
	self:_killTween()

	if self.matProgress then
		UnityEngine.Object.Destroy(self.matProgress)
	end
end

function SodacheLevelItem:_btnOnClick()
	SodacheController.instance:dispatchEvent(SodacheEvent.OnClickLevelItem, self.index)
end

function SodacheLevelItem:setData(config)
	self.config = config

	local outsideMo = SodacheModel.instance:getOutsideMo()

	self.curLvl = outsideMo.prop.level
	self.txtLevelL.text = config.level
	self.txtLevelU.text = config.level
	self.txtLevelS.text = config.level

	local value = 0

	if self.config.level == self.curLvl then
		local nextCfg = lua_sodache_level.configDict[self.curLvl + 1]

		value = nextCfg and outsideMo.prop.exp / nextCfg.cosume or 1
	else
		value = self.config.level > self.curLvl and 0 or 1
	end

	SodacheUtil.setMaterialValue(self.matProgress, value)
	self:refreshSelect()
end

function SodacheLevelItem:setSelect(isSelect)
	self.isSelect = isSelect

	self:refreshSelect()
end

function SodacheLevelItem:refreshSelect()
	gohelper.setActive(self.goLock, self.config.level > self.curLvl)
	gohelper.setActive(self.goUnlock, not self.isSelect and self.config.level <= self.curLvl)
	gohelper.setActive(self.goSelect, self.isSelect and self.config.level <= self.curLvl)
end

function SodacheLevelItem:setScale01(s)
	s = s or 1
	s = GameUtil.remap(s, 0, 1, SodacheLevelItem.ScalerSelectedAdjacent, SodacheLevelItem.ScalerSelected)

	self:setScale(s)
end

function SodacheLevelItem:setScale(s, isAnim)
	if isAnim then
		self:tweenScale(s)
	else
		transformhelper.setLocalScale(self.transform, s, s, s)
	end
end

function SodacheLevelItem:tweenScale(s, duration)
	duration = duration or 0.2

	self:_killTween()

	self._tweenId = ZProj.TweenHelper.DOScale(self.transform, s, s, s, duration, nil, nil, nil)
end

function SodacheLevelItem:_killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

return SodacheLevelItem
