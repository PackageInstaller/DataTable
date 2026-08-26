-- chunkname: @modules/logic/versionactivity3_6/yami/view/common/V3a6YaMiLevelExpComp.lua

module("modules.logic.versionactivity3_6.yami.view.common.V3a6YaMiLevelExpComp", package.seeall)

local V3a6YaMiLevelExpComp = class("V3a6YaMiLevelExpComp", ListScrollCellExtend)

function V3a6YaMiLevelExpComp:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "root")
	self._txtlevel = gohelper.findChildText(self.viewGO, "root/#txt_level")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "root/#image_progress")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_click")
	self._goreddot = gohelper.findChild(self.viewGO, "root/#go_reddot")
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "txt/#btn_tips")
	self._gotips = gohelper.findChild(self.viewGO, "txt/#go_tips")
	self._txtinfo = gohelper.findChildText(self.viewGO, "txt/#go_tips/#txt_info")
	self._txtprogressNum = gohelper.findChildText(self.viewGO, "#txt_progressNum")
	self._gomaxtext = gohelper.findChild(self.viewGO, "#go_maxtext")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiLevelExpComp:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btntips:AddClickListener(self._btntipsOnClick, self)
end

function V3a6YaMiLevelExpComp:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btntips:RemoveClickListener()
end

function V3a6YaMiLevelExpComp:_btnclickOnClick()
	if self._saveLevelExp then
		if not (self._saveLevelExp + (self._tempExp or 0)) then
			local exp = self._totalExp

			self:saveTotalExp(exp)
			V3a6YaMiController.instance:openTaskView()
		end
	end
end

function V3a6YaMiLevelExpComp:_btntipsOnClick()
	gohelper.setActive(self._gotips, true)
end

function V3a6YaMiLevelExpComp:_editableInitView()
	gohelper.setActive(self._gotips, false)

	self._anim = self._goRoot:GetComponent(typeof(UnityEngine.Animator))
end

function V3a6YaMiLevelExpComp:init(go)
	self.viewGO = go

	self:onInitView()
end

function V3a6YaMiLevelExpComp:addEventListeners()
	self:addEvents()
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onRefreshLevelExp, self._refresh, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onReturnMainView, self._refresh, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)

	self._animEvent = self._goRoot:GetComponent(typeof(ZProj.AnimationEventWrap))

	if self._animEvent then
		self._animEvent:AddEventListener(V3a6YaMiEnum.AnimEventName.RefreshLevelExpAnim, self._refreshLevelExp, self)
	end
end

function V3a6YaMiLevelExpComp:removeEventListeners()
	self:removeEvents()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onRefreshLevelExp, self._refresh, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onReturnMainView, self._refresh, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)

	if self._animEvent then
		self._animEvent:RemoveEventListener(V3a6YaMiEnum.AnimEventName.RefreshLevelExpAnim)
	end
end

function V3a6YaMiLevelExpComp:_onCloseView(viewName)
	if self._isCanOpenTask and viewName == ViewName.V3a6YaMiTaskView then
		self:_refresh()
	end
end

function V3a6YaMiLevelExpComp:onUpdateMO(mo)
	self._isCanOpenTask = mo.isCanOpenTask
	self._isAnim = mo.isAnim

	gohelper.setActive(self._btnclick.gameObject, self._isCanOpenTask)
	self:_refresh()
end

function V3a6YaMiLevelExpComp:_refresh()
	self._totalExp = V3a6YaMiModel.instance:getLevelExp()

	local level, exp, needExp = self:_parseLevelExp(self._totalExp)

	self._level, self._exp, self._needExp = level, exp, needExp

	self:_clear()

	if self._isAnim then
		self._saveLevelExp = GameUtil.playerPrefsGetNumberByUserId(V3a6YaMiEnum.PrefsKey.LevelExp, 0)

		if self._saveLevelExp < self._totalExp then
			local level, exp, needExp = self:_parseLevelExp(self._saveLevelExp)

			self._tempLevel, self._tempExp, self._tempNeedExp = level, exp, needExp

			self:_tweenLevelExp()

			return
		end
	end

	self:_showLevelExp()
end

function V3a6YaMiLevelExpComp:_parseLevelExp(totalExp)
	local level, exp = V3a6YaMiModel.instance:parseLevelExp(totalExp)
	local levelCo = V3a6YaMiConfig.instance:getLevelCo(level)
	local nextLevelCo = V3a6YaMiConfig.instance:getLevelCo(level + 1)

	if nextLevelCo then
		if levelCo then
			local needExp = (nextLevelCo.exp or 0) - (levelCo.exp or 0)

			return level, exp, needExp
		end
	end
end

function V3a6YaMiLevelExpComp:_tweenLevelExp()
	if self._tempLevel == self._level then
		if self._tempExp == self._exp then
			self:_showLevelExp()
			self:saveTotalExp()

			return
		end

		self:_doTweenFloatExp(self._exp)

		return
	end

	self:_doTweenFloatExp(self._tempNeedExp)
end

function V3a6YaMiLevelExpComp:_showLevelExp(level, exp, needExp)
	self:_clear()

	level = level or self._level
	exp = exp or self._exp
	needExp = needExp or self._needExp

	local _needExp = needExp or exp
	local var_15_0

	if _needExp < 0 then
		var_15_0 = 1
	elseif needExp then
		var_15_0 = exp / needExp or 1
	end

	self._imageprogress.fillAmount = var_15_0
	self._txtprogressNum.text = string.format("%s/%s", exp, _needExp)
	self._txtlevel.text = level

	gohelper.setActive(self._txtprogressNum.gameObject, _needExp > 0)
	gohelper.setActive(self._gomaxtext.gameObject, _needExp <= 0)
end

function V3a6YaMiLevelExpComp:_doTweenFloatExp(targetExp)
	local exp = self._tempExp
	local time = (targetExp - exp) * 0.001

	time = Mathf.Clamp(time, 0.2, 1)

	local needExp = self._tempNeedExp

	if not self._tempNeedExp then
		local co = V3a6YaMiConfig.instance:getLevelCo(self._level)

		needExp = co.exp
	end

	self:_showLevelExp(self._tempLevel, exp, needExp)

	local easeType = EaseType.Linear

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(exp, targetExp, time, self._tweenExpFrame, self._tweenExpFinish, self, nil, easeType)

	ZProj.TweenHelper.DOFillAmount(self._imageprogress, targetExp / needExp, time, nil, self, nil, easeType)
end

function V3a6YaMiLevelExpComp:_tweenExpFrame(value)
	if not self._tempNeedExp then
		self._tempExp = math.ceil(value)
		self._txtprogressNum.text = string.format("%s/%s", self._tempExp, self._tempNeedExp)
	end
end

function V3a6YaMiLevelExpComp:_tweenExpFinish()
	if self._tempLevel == self._level then
		self:_showLevelExp()
		self:saveTotalExp()

		return
	end

	if self._tempExp <= self._tempNeedExp then
		if self._tempLevel == self._level then
			self:_showLevelExp()
			self:saveTotalExp()

			return
		end

		self._tempLevel = self._tempLevel + 1

		local levelCo = V3a6YaMiConfig.instance:getLevelCo(self._tempLevel)

		self._saveLevelExp = levelCo.exp or self._totalExp

		self:_playLevelUpAnim()

		return
	end
end

function V3a6YaMiLevelExpComp:saveTotalExp(exp)
	if exp and exp > self._totalExp then
		exp = self._totalExp
	end

	GameUtil.playerPrefsSetNumberByUserId(V3a6YaMiEnum.PrefsKey.LevelExp, exp or self._totalExp)
end

function V3a6YaMiLevelExpComp:_playLevelUpAnim()
	AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_level)
	self._anim:Play("levelup", 0, 0)
end

function V3a6YaMiLevelExpComp:_refreshLevelExp()
	ZProj.TweenHelper.KillByObj(self._imageprogress)

	self._imageprogress.fillAmount = 0

	local levelCo = V3a6YaMiConfig.instance:getLevelCo(self._tempLevel)

	if levelCo then
		if not levelCo.exp then
			local curLevelNeedExp = 0
			local nextLevelCo = V3a6YaMiConfig.instance:getLevelCo(self._tempLevel + 1)

			if nextLevelCo then
				self._tempNeedExp = nextLevelCo.exp - curLevelNeedExp
				self._tempExp = 0

				self:_tweenLevelExp()
			else
				self._tempNeedExp = curLevelNeedExp

				self:_showLevelExp()
				self:saveTotalExp()
			end
		end
	end
end

function V3a6YaMiLevelExpComp:_clear()
	ZProj.TweenHelper.KillByObj(self._imageprogress)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function V3a6YaMiLevelExpComp:onDestroy()
	self:_clear()

	if self._isAnim then
		self:saveTotalExp()
	end
end

return V3a6YaMiLevelExpComp
