-- chunkname: @modules/logic/versionactivity1_4/act129/view/Activity129EntranceView.lua

module("modules.logic.versionactivity1_4.act129.view.Activity129EntranceView", package.seeall)

local Activity129EntranceView = class("Activity129EntranceView", BaseView)

function Activity129EntranceView:onInitView()
	self.goEntrance = gohelper.findChild(self.viewGO, "#go_Entrance")
	self.txtLimitTime = gohelper.findChildTextMesh(self.viewGO, "#go_Entrance/Title/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self.itemDict = {}
	self.anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity129EntranceView:addEvents()
	self.addEventCb(self, Activity129Controller.instance, Activity129Event.OnEnterPool, self.onEnterPool, self)
	self.addEventCb(self, Activity129Controller.instance, Activity129Event.OnGetInfoSuccess, self.OnGetInfoSuccess, self)
end

function Activity129EntranceView:removeEvents()
	self.removeEventCb(self, Activity129Controller.instance, Activity129Event.OnEnterPool, self.onEnterPool, self)
	self.removeEventCb(self, Activity129Controller.instance, Activity129Event.OnGetInfoSuccess, self.OnGetInfoSuccess, self)
end

function Activity129EntranceView:_editableInitView()
	return
end

function Activity129EntranceView:onUpdateParam()
	return
end

function Activity129EntranceView:onEnterPool()
	self:refreshView()
end

function Activity129EntranceView:OnGetInfoSuccess()
	self:refreshView(true)
end

function Activity129EntranceView:onOpen()
	self.actId = self.viewParam.actId
	self.isOpen = true

	self:refreshView()
end

function Activity129EntranceView:refreshView(isUpdate)
	TaskDispatcher.cancelTask(self.refreshLeftTime, self)

	local selectPoolId = Activity129Model.instance:getSelectPoolId()

	if selectPoolId then
		gohelper.setActive(self.goEntrance, false)

		self.isOpen = false

		return
	end

	gohelper.setActive(self.goEntrance, true)

	if not self.isOpen then
		self.anim:Play("switch", 0, 0)
	end

	self.isOpen = true

	if not isUpdate then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_open)
	end

	local pools = Activity129Config.instance:getPoolDict(self.actId)

	if pools then
		for k, v in pairs(pools) do
			local item = self.itemDict[v.poolId]

			item = item or self:createPoolItem(v.poolId)

			self:refreshPoolItem(item, v)
		end
	end

	self:refreshLeftTime()
	TaskDispatcher.runRepeat(self.refreshLeftTime, self, 60)
end

function Activity129EntranceView:createPoolItem(poolId)
	local item = self:getUserDataTb_()

	item.poolId = poolId
	item.go = gohelper.findChild(self.goEntrance, string.format("Item%s", poolId))
	item.goItems = gohelper.findChild(item.go, "items")
	item.txtItemTitle = gohelper.findChildTextMesh(item.go, "items/txt_ItemTitle")
	item.goGet = gohelper.findChild(item.go, "#go_Get")
	item.click = gohelper.findChildClickWithAudio(item.go, "click", AudioEnum.UI.play_ui_payment_click)

	item.click:AddClickListener(self._onClickItem, self, item)

	item.simages = item.goItems:GetComponentsInChildren(typeof(SLFramework.UGUI.SingleImage), true)

	local iter = item.simages:GetEnumerator()

	while iter:MoveNext() do
		local str = iter.Current.curImageUrl

		iter.Current.curImageUrl = nil

		iter.Current:LoadImage(str)
	end

	item.graphics = {}

	local imgs = item.goItems:GetComponentsInChildren(gohelper.Type_Image, true)
	local iterimg = imgs:GetEnumerator()

	while iterimg:MoveNext() do
		table.insert(item.graphics, {
			comp = iterimg.Current,
			color = GameUtil.colorToHex(iterimg.Current.color)
		})
	end

	local tmps = item.goItems:GetComponentsInChildren(gohelper.Type_TextMesh, true)
	local itertmp = tmps:GetEnumerator()

	while itertmp:MoveNext() do
		table.insert(item.graphics, {
			comp = itertmp.Current,
			color = GameUtil.colorToHex(itertmp.Current.color)
		})
	end

	self.itemDict[poolId] = item

	return item
end

function Activity129EntranceView:refreshPoolItem(item, config)
	item.txtItemTitle.text = config.name

	local isEmpty = Activity129Model.instance:checkPoolIsEmpty(self.actId, config.poolId)

	gohelper.setActive(item.goGet, isEmpty)

	for i, v in ipairs(item.graphics) do
		SLFramework.UGUI.GuiHelper.SetColor(v.comp, isEmpty and "#808080" or v.color)
	end
end

function Activity129EntranceView:_onClickItem(item)
	Activity129Model.instance:setSelectPoolId(item.poolId)
end

function Activity129EntranceView:refreshLeftTime()
	local actMO = ActivityModel.instance:getActMO(self.actId)

	if actMO then
		self.txtLimitTime.text = formatLuaLang("remain", string.format("%s%s", actMO:getRemainTime()))
	end
end

function Activity129EntranceView:onClose()
	TaskDispatcher.cancelTask(self.refreshLeftTime, self)
end

function Activity129EntranceView:onDestroyView()
	for k, item in pairs(self.itemDict) do
		local iter = item.simages:GetEnumerator()

		while iter:MoveNext() do
			iter.Current:UnLoadImage()
		end

		item.click:RemoveClickListener()
	end
end

return Activity129EntranceView
