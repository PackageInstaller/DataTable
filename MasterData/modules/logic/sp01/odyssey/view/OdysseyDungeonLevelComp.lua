-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyDungeonLevelComp.lua

module("modules.logic.sp01.odyssey.view.OdysseyDungeonLevelComp", package.seeall)

local OdysseyDungeonLevelComp = class("OdysseyDungeonLevelComp", LuaCompBase)

function OdysseyDungeonLevelComp:ctor(param)
	self.param = param
end

function OdysseyDungeonLevelComp:init(go)
	self:__onInit()

	self.go = go
	self._txtlevel = gohelper.findChildText(self.go, "#txt_level")
	self._txtlevel1 = gohelper.findChildText(self.go, "#txt_level1")
	self._btnlevelReward = gohelper.findChildButtonWithAudio(self.go, "#btn_levelReward")
	self._golevelBar = gohelper.findChild(self.go, "#go_levelBar")
	self._goaddLevelProgress = gohelper.findChild(self.go, "#go_levelBar/bar/#go_addLevelProgress")
	self._golevelProgress = gohelper.findChild(self.go, "#go_levelBar/bar/#go_levelProgress")
	self._gotargetLevelProgress = gohelper.findChild(self.go, "#go_levelBar/bar/#go_targetLevelProgress")
	self._txtexpAdd = gohelper.findChildText(self.go, "#go_levelBar/#txt_expAdd")
	self._golevelReddot = gohelper.findChild(self.go, "#go_levelReddot")
	self._animLevel = self.go:GetComponent(gohelper.Type_Animator)
	self.expBarWidth = recthelper.getWidth(self._golevelBar.transform)
	self._animlevelBar = gohelper.findChild(self.go, "#go_levelBar/bar"):GetComponent(gohelper.Type_Animator)

	gohelper.setActive(self._golevelBar, false)

	local heroOldLevel, heroOldExp = OdysseyModel.instance:getHeroOldLevelAndExp()

	self.curLevel = heroOldLevel
	self.curExp = heroOldExp
	self.showState = true

	local levelConfigList = OdysseyConfig.instance:getLevelConfigList()

	self.maxLevelConfig = levelConfigList[#levelConfigList]
end

function OdysseyDungeonLevelComp:addEventListeners()
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.ShowAddExpEffect, self.showExpAdd, self)
	self._btnlevelReward:AddClickListener(self._btnlevelRewardOnClick, self)
end

function OdysseyDungeonLevelComp:removeEventListeners()
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.ShowAddExpEffect, self.showExpAdd, self)
	self._btnlevelReward:RemoveClickListener()
end

function OdysseyDungeonLevelComp:_btnlevelRewardOnClick()
	OdysseyDungeonController.instance:openLevelRewardView()
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnlevelRewardOnClick")
end

function OdysseyDungeonLevelComp:refreshUI()
	self._txtlevel.text = self.curLevel
	self._txtlevel1.text = self.curLevel

	RedDotController.instance:addRedDot(self._golevelReddot, RedDotEnum.DotNode.OdysseyLevelReward)
end

OdysseyDungeonLevelComp.TotalExpShowTIme = 1.5

function OdysseyDungeonLevelComp:showExpAdd()
	local heroOldLevel, heroOldExp = OdysseyModel.instance:getHeroOldLevelAndExp()

	self.curLevel = heroOldLevel
	self.curExp = heroOldExp

	if self.curLevel == self.maxLevelConfig.level then
		return
	end

	gohelper.setActive(self._golevelBar, true)
	self._animlevelBar:Play("open", 0, 0)
	self._animlevelBar:Update(0)

	self._txtexpAdd.text = string.format("+%s", OdysseyModel.instance:getHeroAddExp())
	self.heroTargetLevel, self.heroTargetExp = OdysseyModel.instance:getHeroCurLevelAndExp()
	self.curLevelCo = OdysseyConfig.instance:getLevelConfig(self.curLevel)
	self.targetLevelCo = OdysseyConfig.instance:getLevelConfig(self.heroTargetLevel)
	self._txtlevel.text = self.curLevel
	self._txtlevel1.text = self.curLevel

	if not self.curLevelCo or not self.targetLevelCo then
		self._txtlevel.text = self.heroTargetLevel
		self._txtlevel1.text = self.heroTargetLevel

		return
	end

	recthelper.setWidth(self._golevelProgress.transform, self.curExp / self.curLevelCo.needExp * self.expBarWidth)

	self.eachAnimTime = OdysseyDungeonLevelComp.TotalExpShowTIme / Mathf.Max(self.heroTargetLevel - heroOldLevel, 1)
	self.animCount = 0

	self:ExpAddAnim()
end

function OdysseyDungeonLevelComp:ExpAddAnim()
	self:cleanExpTween()

	local curBarWidth = recthelper.getWidth(self._golevelProgress.transform)

	if self.targetLevelCo.needExp > 0 then
		if not (self.heroTargetExp / self.targetLevelCo.needExp * self.expBarWidth) then
			local targetExpBarWidth = curBarWidth

			if self.curLevel == self.heroTargetLevel and Mathf.Abs(curBarWidth - targetExpBarWidth) < 1 then
				self:endExpAddAnim()

				return
			elseif self.curLevel < self.heroTargetLevel and Mathf.Abs(curBarWidth - self.expBarWidth) < 1 then
				self.curLevel = self.curLevel + 1
				self._txtlevel.text = self.curLevel
				self._txtlevel1.text = self.curLevel

				if not self.isPlayingLevelUpAnim then
					self._animLevel:Play("up", 0, 0)

					self.isPlayingLevelUpAnim = true

					if self.showState then
						AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_level_up)
					end
				end

				recthelper.setWidth(self._golevelProgress.transform, 0)

				if targetExpBarWidth == 0 and self.curLevel == self.heroTargetLevel then
					self:endExpAddAnim()

					return
				end
			end

			if self.curLevel ~= self.heroTargetLevel then
				gohelper.setActive(self._gotargetLevelProgress, true)
				gohelper.setActive(self._goaddLevelProgress, true)
				recthelper.setWidth(self._gotargetLevelProgress.transform, targetExpBarWidth)
				recthelper.setWidth(self._goaddLevelProgress.transform, self.expBarWidth)

				self.expTweenId = ZProj.TweenHelper.DOWidth(self._golevelProgress.transform, self.expBarWidth, self.eachAnimTime, self.ExpAddAnim, self)
			else
				gohelper.setActive(self._gotargetLevelProgress, false)
				gohelper.setActive(self._goaddLevelProgress, true)
				recthelper.setWidth(self._goaddLevelProgress.transform, targetExpBarWidth)

				self.expTweenId = ZProj.TweenHelper.DOWidth(self._golevelProgress.transform, targetExpBarWidth, self.eachAnimTime, self.ExpAddAnim, self)
			end
		end
	end
end

function OdysseyDungeonLevelComp:checkLevelDiffAndRefresh()
	self.heroTargetLevel, self.heroTargetExp = OdysseyModel.instance:getHeroCurLevelAndExp()

	local heroOldLevel, heroOldExp = OdysseyModel.instance:getHeroOldLevelAndExp()

	if self.curLevel < self.heroTargetLevel or heroOldExp ~= self.heroTargetExp then
		self.eachAnimTime = OdysseyDungeonLevelComp.TotalExpShowTIme / Mathf.Max(self.heroTargetLevel - heroOldLevel, 1)
		self.animCount = 0
		self.targetLevelCo = OdysseyConfig.instance:getLevelConfig(self.heroTargetLevel)

		self:ExpAddAnim()
	end
end

function OdysseyDungeonLevelComp:endExpAddAnim()
	gohelper.setActive(self._gotargetLevelProgress, false)
	gohelper.setActive(self._goaddLevelProgress, false)
	self._animlevelBar:Play("close", 0, 0)
	self._animlevelBar:Update(0)
	TaskDispatcher.runDelay(self.hideLevelBar, self, 0.17)

	self._txtexpAdd.text = ""
	self.isPlayingLevelUpAnim = false

	OdysseyModel.instance:updateHeroOldLevel(self.heroTargetLevel, self.heroTargetExp)
	self:refreshUI()
end

function OdysseyDungeonLevelComp:hideLevelBar()
	gohelper.setActive(self._golevelBar, false)
end

function OdysseyDungeonLevelComp:setShowState(state)
	self.showState = state
end

function OdysseyDungeonLevelComp:cleanExpTween()
	if self.expTweenId then
		ZProj.TweenHelper.KillById(self.expTweenId)

		self.expTweenId = nil
	end

	TaskDispatcher.cancelTask(self.hideLevelBar, self)
end

function OdysseyDungeonLevelComp:destroy()
	self:__onDispose()
	self:cleanExpTween()
end

return OdysseyDungeonLevelComp
