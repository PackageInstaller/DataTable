-- chunkname: @modules/logic/versionactivity1_3/buff/view/VersionActivity1_3BuffItem.lua

module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3BuffItem", package.seeall)

local VersionActivity1_3BuffItem = class("VersionActivity1_3BuffItem", ListScrollCellExtend)

function VersionActivity1_3BuffItem:onInitView()
	self._imageBuffBG = gohelper.findChildImage(self.viewGO, "Root/#image_BuffBG")
	self._imageBuffBG1 = gohelper.findChildImage(self.viewGO, "Root/#image_BuffBG1")
	self._imageBuffIcon = gohelper.findChildImage(self.viewGO, "Root/#image_BuffIcon")
	self._simageBuffIcon1 = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_BuffIcon1")
	self._simageBuffIcon2 = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_BuffIcon2")
	self._goUnLocked = gohelper.findChild(self.viewGO, "Root/#go_UnLocked")
	self._goLocked = gohelper.findChild(self.viewGO, "Root/#go_Locked")
	self._simageBuffNumBg = gohelper.findChildSingleImage(self.viewGO, "Root/#go_Locked/#simage_BuffNumBg")
	self._txtBuffNum = gohelper.findChildText(self.viewGO, "Root/#go_Locked/#txt_BuffNum")
	self._gotaskLocked = gohelper.findChild(self.viewGO, "Root/#go_Locked/#go_taskLocked")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3BuffItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function VersionActivity1_3BuffItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function VersionActivity1_3BuffItem:_btnclickOnClick()
	ViewMgr.instance:openView(ViewName.VersionActivity1_3BuffTipView, {
		self._config,
		self._isLock,
		self._canGet,
		self
	})
end

function VersionActivity1_3BuffItem:ctor(param)
	self._config = param[1]
	self._pathGo = param[2]

	local image = self._pathGo:GetComponent(gohelper.Type_Image)

	self._pathMat = image.material

	self:_changeSub(0)
end

function VersionActivity1_3BuffItem:_editableInitView()
	gohelper.setActive(self._simageBuffNumBg, false)

	self._matKey = UnityEngine.Shader.PropertyToID("_Sub")

	UISpriteSetMgr.instance:setV1a3BuffIconSprite(self._imageBuffIcon, self._config.icon, true)

	local iconUrl = string.format("singlebg/v1a3_buffview_singlebg/%s.png", self._config.icon)

	self._simageBuffIcon1:LoadImage(iconUrl, self._loadDone1, self)
	self._simageBuffIcon2:LoadImage(iconUrl, self._loadDone2, self)

	local img = gohelper.findChildImage(self.viewGO, "Root/#simage_BuffIcon1")
	local mat = UnityEngine.GameObject.Instantiate(img.material)

	img.material = mat

	local rootGo = gohelper.findChild(self.viewGO, "Root")

	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(rootGo)
	self._animator = rootGo:GetComponent(typeof(UnityEngine.Animator))
	self._animator.enabled = false

	local materialPropsCtrl = rootGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	local mats = materialPropsCtrl.mas

	mats[0] = mat
	self._goVx1 = gohelper.findChild(self.viewGO, "Root/vx/1")
	self._goVx2 = gohelper.findChild(self.viewGO, "Root/vx/2")

	local showVx1 = self._config.dreamlandCard == 0

	gohelper.setActive(self._goVx1, showVx1)
	gohelper.setActive(self._goVx2, not showVx1)
	self:updateStatus()
end

function VersionActivity1_3BuffItem:_loadDone1()
	local img = gohelper.findChildImage(self.viewGO, "Root/#simage_BuffIcon1")

	img:SetNativeSize()
end

function VersionActivity1_3BuffItem:_loadDone2()
	local img = gohelper.findChildImage(self.viewGO, "Root/#simage_BuffIcon2")

	img:SetNativeSize()
end

function VersionActivity1_3BuffItem:showLockToast()
	return self:_checkCanGet(true)
end

function VersionActivity1_3BuffItem:_checkCanGet(showToast)
	local checkCost = true
	local checkPreBuff = true
	local checkTask = true
	local costStr = self._config.cost

	if not string.nilorempty(costStr) then
		local list = string.splitToNumber(costStr, "#")
		local costNum = list[3]
		local ownNum = ItemModel.instance:getItemQuantity(list[1], list[2])

		checkCost = costNum <= ownNum

		if not checkCost and showToast then
			return formatLuaLang("versionactivity1_3_buff_tip1", costNum)
		end
	end

	if self._config.preBuffId > 0 and not Activity126Model.instance:hasBuff(self._config.preBuffId) then
		checkPreBuff = false

		if not checkPreBuff and showToast then
			return luaLang("versionactivity1_3_buff_tip2")
		end
	end

	if self._config.taskId > 0 and not TaskModel.instance:taskHasFinished(TaskEnum.TaskType.ActivityDungeon, self._config.taskId) then
		checkTask = false

		if showToast then
			return
		end
	end

	return checkCost and checkPreBuff and checkTask
end

function VersionActivity1_3BuffItem:updateStatus()
	local buffId = self._config.id
	local isLock = not Activity126Model.instance:hasBuff(buffId)
	local canGet = self:_checkCanGet()

	UISpriteSetMgr.instance:setV1a3BuffIconSprite(self._imageBuffBG, isLock and "v1a3_buffview_bufficonbg_2" or "v1a3_buffview_bufficonbg_1")
	gohelper.setActive(self._goLocked, isLock)
	gohelper.setActive(self._goUnLocked, isLock and canGet)

	if self._config.dreamlandCard == 0 then
		gohelper.setActive(self._pathGo, not isLock)
	end

	self._isLock = isLock
	self._canGet = canGet

	if not isLock then
		self._animator.enabled = true

		self._animator:Play("idle", 0, 0)

		return
	end

	if isLock then
		local list = string.splitToNumber(self._config.cost, "#")
		local costNum = list[3]

		gohelper.setActive(self._gotaskLocked, self._config.taskId > 0)

		self._txtBuffNum.text = costNum

		if costNum and costNum > 0 then
			gohelper.setActive(self._simageBuffNumBg, true)
		end
	else
		self._imageBuffIcon.color = Color.white

		ZProj.UGUIHelper.SetGrayscale(self._imageBuffIcon.gameObject, false)
		gohelper.setActive(self._simageBuffIcon1, true)
		gohelper.setActive(self._simageBuffIcon2, true)
	end
end

function VersionActivity1_3BuffItem:onUnlockBuffReply()
	if self._isLock and Activity126Model.instance:hasBuff(self._config.id) then
		self._isLock = nil

		UIBlockMgr.instance:startBlock("1_3UnlockBuffReply")

		if self._config.dreamlandCard == 0 then
			self:_showUnlockAnim()
		else
			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_sky_unlock_special)
			self:_onTweenFinish()
		end
	else
		self:updateStatus()
	end
end

function VersionActivity1_3BuffItem:_showUnlockAnim()
	self:_changeSub(1)
	gohelper.setActive(self._pathGo, true)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_sky_unlock_general)

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0.5, 1, self._onTweenFrame, self._onTweenFinish, self, nil, EaseType.Linear)
end

function VersionActivity1_3BuffItem:_onTweenFrame(value)
	self:_changeSub(value)
end

function VersionActivity1_3BuffItem:_onTweenFinish()
	self:_changeSub(0)

	self._animator.enabled = true

	self._animator:Play("unlock", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	TaskDispatcher.cancelTask(self._unlockDone, self)
	TaskDispatcher.runDelay(self._unlockDone, self, 2)
end

function VersionActivity1_3BuffItem:_unlockDone()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("1_3UnlockBuffReply")
	GameFacade.showToast(ToastEnum.Activity126_tip10, self._config.name)
end

function VersionActivity1_3BuffItem:_changeSub(value)
	self._pathMat:SetFloat(self._matKey, value)
end

function VersionActivity1_3BuffItem:onUpdateMO(mo)
	return
end

function VersionActivity1_3BuffItem:onSelect(isSelect)
	return
end

function VersionActivity1_3BuffItem:onDestroyView()
	self._simageBuffIcon1:UnLoadImage()
	self._simageBuffIcon2:UnLoadImage()

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(self._unlockDone, self)
	UIBlockMgr.instance:endBlock("1_3UnlockBuffReply")
end

return VersionActivity1_3BuffItem
