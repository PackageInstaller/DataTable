-- chunkname: @modules/logic/sodache/view/outside/SodacheLevelUpView.lua

module("modules.logic.sodache.view.outside.SodacheLevelUpView", package.seeall)

local SodacheLevelUpView = class("SodacheLevelUpView", BaseView)

function SodacheLevelUpView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._imageLevel = gohelper.findChildImage(self.viewGO, "level/#image_Level")
	self._txtLevel = gohelper.findChildText(self.viewGO, "level/#txt_Level")
	self._imageProgress = gohelper.findChildImage(self.viewGO, "Progress/#image_Progress")
	self._txtProgress = gohelper.findChildText(self.viewGO, "Progress/#txt_Progress")
	self._goMax = gohelper.findChild(self.viewGO, "Progress/#go_Max")
	self._txtDesc = gohelper.findChildText(self.viewGO, "unlock/#txt_Desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheLevelUpView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function SodacheLevelUpView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function SodacheLevelUpView:_btnCloseOnClick()
	if self.canClick then
		self:closeThis()
	end
end

function SodacheLevelUpView:_editableInitView()
	self.matLevel = UnityEngine.Object.Instantiate(self._imageLevel.material)
	self._imageLevel.material = self.matLevel
end

function SodacheLevelUpView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_7.Sodache.levelup)

	local outsideMo = SodacheModel.instance:getOutsideMo()

	self.prop = outsideMo.prop

	local curCfg = lua_sodache_level.configDict[self.prop.level]

	self._txtLevel.text = self.prop.oldLevel
	self._txtDesc.text = SodacheUtil.changeDescColor(curCfg.desc)
	self.nextCfg = lua_sodache_level.configDict[self.prop.level + 1]

	if self.nextCfg then
		self._txtProgress.text = string.format("%s/%s", self.prop.exp, self.nextCfg.cosume)
		self._imageProgress.fillAmount = self.prop.exp / self.nextCfg.cosume
	else
		self._imageProgress.fillAmount = 1
	end

	gohelper.setActive(self._txtProgress, self.nextCfg)
	gohelper.setActive(self._goMax, not self.nextCfg)

	local startNextCfg = lua_sodache_level.configDict[self.prop.oldLevel + 1]
	local value = self.prop.oldExp / startNextCfg.cosume

	SodacheUtil.setMaterialValue(self.matLevel, value)

	self.diffLvl = self.prop.level - self.prop.oldLevel

	if self.diffLvl ~= 0 then
		TaskDispatcher.runDelay(self.delayPlay, self, 0.35)
	else
		logError("数据异常，未升级进入了升级界面")
		self:closeThis()
	end
end

function SodacheLevelUpView:onDestroyView()
	if self.prop then
		self.prop:clearOldLevel()
		self.prop:clearOldExp()
	end

	TaskDispatcher.cancelTask(self.loop, self)
	TaskDispatcher.cancelTask(self.setSafety, self)

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	if self.matLevel then
		UnityEngine.Object.Destroy(self.matLevel)
	end
end

function SodacheLevelUpView:delayPlay()
	self.addLevel = 0

	self:loop()
	TaskDispatcher.runDelay(self.setSafety, self, 2)
end

function SodacheLevelUpView:loop()
	local begin, final = 0, 1

	if self.addLevel == 0 then
		local nextCfg = lua_sodache_level.configDict[self.prop.oldLevel + 1]

		begin = self.prop.oldExp / nextCfg.cosume
	elseif self.addLevel == self.diffLvl then
		local nextCfg = lua_sodache_level.configDict[self.prop.level + 1]

		if nextCfg then
			if self.prop.exp == 0 then
				self:_frameCall(0)
				self:setSafety()

				return
			else
				final = self.prop.exp / nextCfg.cosume
			end
		else
			self:_frameCall(1)
			self:setSafety()

			return
		end
	end

	local duration = (final - begin) * SodacheEnum.LevelProgressTime

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
		self:_endCall()
	end

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(begin, final, duration, self._frameCall, self._endCall, self, nil, EaseType.Linear)

	if self.addLevel < self.diffLvl then
		self.addLevel = self.addLevel + 1

		TaskDispatcher.runDelay(self.loop, self, duration)
	else
		self:setSafety()
	end
end

function SodacheLevelUpView:_frameCall(value)
	if self.matLevel then
		SodacheUtil.setMaterialValue(self.matLevel, value)
	end
end

function SodacheLevelUpView:_endCall()
	self._txtLevel.text = self.prop.oldLevel + self.addLevel
end

function SodacheLevelUpView:setSafety()
	self.canClick = true
end

return SodacheLevelUpView
