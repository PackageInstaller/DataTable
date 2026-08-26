-- chunkname: @modules/logic/versionactivity3_6/enter/view/VersionActivity3_6EnterViewTabItem2.lua

module("modules.logic.versionactivity3_6.enter.view.VersionActivity3_6EnterViewTabItem2", package.seeall)

local VersionActivity3_6EnterViewTabItem2 = class("VersionActivity3_6EnterViewTabItem2", VersionActivityFixedEnterViewTabItemBase)

function VersionActivity3_6EnterViewTabItem2:init(go)
	if gohelper.isNil(go) then
		return
	end

	VersionActivity3_6EnterViewTabItem2.super.init(go)

	self.go = go
	self.rectTr = self.go:GetComponent(gohelper.Type_RectTransform)
	self.clickCollider = ZProj.BoxColliderClickListener.Get(go)

	self.clickCollider:SetIgnoreUI(true)

	self.click = gohelper.getClickWithDefaultAudio(self.go)

	self:_editableInitView()
	gohelper.setActive(self.go, true)
end

function VersionActivity3_6EnterViewTabItem2:_editableInitView()
	VersionActivity3_6EnterViewTabItem2.super._editableInitView(self)

	self.txtName = gohelper.findChildText(self.go, "#txt_name")
	self.txtNameEn = gohelper.findChildText(self.go, "#txt_name/#txt_nameen")
end

function VersionActivity3_6EnterViewTabItem2:addEventListeners()
	VersionActivity3_6EnterViewTabItem2.super.addEventListeners(self)
	self.clickCollider:AddMouseUpListener(self.onClickCollider, self)
end

function VersionActivity3_6EnterViewTabItem2:removeEventListeners()
	VersionActivity3_6EnterViewTabItem2.super.removeEventListeners(self)
	self.clickCollider:RemoveMouseUpListener()
end

function VersionActivity3_6EnterViewTabItem2:_getTagPath()
	return "#go_tag"
end

function VersionActivity3_6EnterViewTabItem2:afterSetData()
	VersionActivity3_6EnterViewTabItem2.super.afterSetData(self)

	local reddotId = self.activityCo.redDotId

	if not VersionActivity3_6Enum.CharacterActId[self.actId] then
		self.redDotIcon = RedDotController.instance:addRedDot(self.goRedDot, reddotId, VersionActivity3_6Enum.CharacterActId[self.actId])

		if self.activityCo then
			self.txtName.text = self.activityCo.name or ""
		end

		if self.activityCo then
			self.txtNameEn.text = self.activityCo.nameEn or ""
		end
	end
end

function VersionActivity3_6EnterViewTabItem2:childRefreshSelect(actId)
	VersionActivity3_6EnterViewTabItem2.super.childRefreshSelect(self, actId)

	local tabSetting = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting.unselect

	if self.isSelect then
		tabSetting = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting.select
	end

	self.txtName.color = GameUtil.parseColor(tabSetting.cnColor)

	local enColor = GameUtil.parseColor(tabSetting.enColor)

	enColor.a = tabSetting.enAlpha or 1
	self.txtNameEn.color = enColor
	self.txtName.fontSize = tabSetting.fontSize
	self.txtNameEn.fontSize = tabSetting.enFontSize
end

function VersionActivity3_6EnterViewTabItem2:onClickCollider()
	if not self:checkIsTopView() then
		return
	end

	if self._isDrag then
		return
	end

	self:onClick()
end

function VersionActivity3_6EnterViewTabItem2:checkIsTopView()
	local openViewList = ViewMgr.instance:getOpenViewNameList()

	for i = #openViewList, 1, -1 do
		local viewName = openViewList[i]

		return viewName == ViewName.VersionActivity3_6EnterView
	end
end

function VersionActivity3_6EnterViewTabItem2:setDrag(isDrag)
	self._isDrag = isDrag
end

function VersionActivity3_6EnterViewTabItem2:onClick()
	if self.isSelect then
		return
	end

	if self.customClick then
		self.customClick(self.customClickObj, self)

		return
	end

	if not self.storeId then
		local checkActId = self.actId
		local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(checkActId)

		if self.actId == VersionActivity3_6Enum.ActivityId.YaMi or status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.NotUnlock then
			self.animator:Play("click", 0, 0)
			VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, self.actId, self)

			return
		end

		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)
	end
end

return VersionActivity3_6EnterViewTabItem2
