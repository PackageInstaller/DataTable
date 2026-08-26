-- chunkname: @modules/logic/versionactivity1_2/enter/view/VersionActivity1_2EnterView.lua

module("modules.logic.versionactivity1_2.enter.view.VersionActivity1_2EnterView", package.seeall)

local VersionActivity1_2EnterView = class("VersionActivity1_2EnterView", VersionActivityEnterBaseView1_2)

function VersionActivity1_2EnterView:onInitView()
	VersionActivity1_2EnterView.super.onInitView(self)

	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "img_bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_2EnterView:addEvents()
	VersionActivity1_2EnterView.super.addEvents(self)
end

function VersionActivity1_2EnterView:removeEvents()
	VersionActivity1_2EnterView.super.removeEvents(self)
end

function VersionActivity1_2EnterView:_editableInitView()
	VersionActivity1_2EnterView.super._editableInitView(self)
	self._simagebg:LoadImage(ResUrl.getVersionActivityEnter1_2Icon("bg_main"))
end

function VersionActivity1_2EnterView:initActivityName()
	for _, activityItem in ipairs(self.activityItemList) do
		if activityItem.actId == VersionActivity1_2Enum.ActivityId.Season or activityItem.actId == VersionActivity1_2Enum.ActivityId.Dungeon then
			local name = activityItem.activityCo.name
			local secondCharIndex = utf8.next_raw(name, 1)
			local firstName = name:sub(1, secondCharIndex - 1)
			local subName = name:sub(secondCharIndex)

			activityItem.txtActivityName.text = string.format("<size=65>%s</size>%s", firstName, subName)
		else
			activityItem.txtActivityName.text = activityItem.activityCo.name
		end
	end
end

function VersionActivity1_2EnterView:refreshTimeContainer(activityItem, isNormalStatus)
	VersionActivity1_2EnterView.super.refreshTimeContainer(self, activityItem, isNormalStatus)
	gohelper.setActive(activityItem.txtTime, not isNormalStatus)
	gohelper.setActive(activityItem.txtRemainTime, isNormalStatus)
end

function VersionActivity1_2EnterView:onClickActivity1()
	Activity117Controller.instance:openView(VersionActivity1_2Enum.ActivityId.Trade)
end

function VersionActivity1_2EnterView:onClickActivity2()
	Activity114Controller.instance:openAct114View()
end

function VersionActivity1_2EnterView:onClickActivity3()
	Activity104Controller.instance:openSeasonMainView()
end

function VersionActivity1_2EnterView:onClickActivity4()
	VersionActivity1_2DungeonController.instance:openDungeonView()
end

function VersionActivity1_2EnterView:onClickActivity5()
	YaXianController.instance:openYaXianMapView()
end

function VersionActivity1_2EnterView:onClickActivity6()
	Activity119Controller.instance:openAct119View()
end

function VersionActivity1_2EnterView:onRefreshActivity3(activityItem)
	local status = ActivityHelper.getActivityStatus(activityItem.actId)
	local isNormal = status == ActivityEnum.ActivityStatus.Normal
	local goWeek = gohelper.findChild(activityItem.goNormal, "#go_week")

	gohelper.setActive(goWeek, isNormal and Activity104Model.instance:isEnterSpecial(activityItem.actId) or false)

	local stageGo = gohelper.findChild(activityItem.goNormal, "stages/#go_stageitem")

	for i = 1, 7 do
		local stageName = "stageitem" .. i
		local curGo = gohelper.findChild(activityItem.goNormal, string.format("stages/%s", stageName))

		if isNormal then
			local stage = Activity104Model.instance:getAct104CurStage(activityItem.actId)

			curGo = curGo or gohelper.cloneInPlace(stageGo, stageName)

			if i == 7 then
				gohelper.setActive(curGo, stage == 7)
			else
				gohelper.setActive(curGo, true)
			end

			local gofull = gohelper.findChild(curGo, "full")

			gohelper.setActive(gofull, i <= stage)
		else
			gohelper.setActive(curGo, false)
		end
	end
end

function VersionActivity1_2EnterView:onRefreshActivity4(activityItem)
	self:initActivityDungeonNode(activityItem)

	local status = ActivityHelper.getActivityStatus(VersionActivity1_2Enum.ActivityId.DungeonStore)

	if status == ActivityEnum.ActivityStatus.NotOnLine or status == ActivityEnum.ActivityStatus.Expired then
		gohelper.setActive(self.activityDungeonNodeItem.store_tr.gameObject, false)

		return
	end

	gohelper.setActive(self.activityDungeonNodeItem.store_tr.gameObject, true)

	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.LvHuEMen)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self.activityDungeonNodeItem.store_txtCurrencyCount.text = GameUtil.numberDisplay(quantity)

			local activityCo = ActivityConfig.instance:getActivityCo(VersionActivity1_2Enum.ActivityId.DungeonStore)

			self.activityDungeonNodeItem.store_txtName.text = activityCo.name

			local isNormalStatus = status == ActivityEnum.ActivityStatus.Normal

			gohelper.setActive(self.activityDungeonNodeItem.store_goRemainTime, isNormalStatus)

			if isNormalStatus then
				local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_2Enum.ActivityId.DungeonStore]

				self.activityDungeonNodeItem.store_txtRemainTime.text = actInfoMo and actInfoMo:getRemainTimeStr2ByEndTime(true) or ""
				self.activityDungeonNodeItem.store_image.color = self.activityDungeonNodeItem.store_imageOriginColor
				self.activityDungeonNodeItem.store_txtCurrencyCount.color = self.activityDungeonNodeItem.store_txtCurrencyCountOriginColor
				self.activityDungeonNodeItem.store_txtName.color = self.activityDungeonNodeItem.store_txtNameOriginColor
			else
				self.activityDungeonNodeItem.store_image.color = self.activityDungeonNodeItem.lockColor
				self.activityDungeonNodeItem.store_txtCurrencyCount.color = self.activityDungeonNodeItem.lockColor
				self.activityDungeonNodeItem.store_txtName.color = self.activityDungeonNodeItem.lockColor
			end

			recthelper.setAnchorY(self.activityDungeonNodeItem.store_tr, activityItem.showTag and 110 or 90)
		end
	end
end

function VersionActivity1_2EnterView:initActivityDungeonNode(activityItem)
	if self.activityDungeonNodeItem then
		return
	end

	self.activityDungeonNodeItem = activityItem
	self.activityDungeonNodeItem.store_tr = gohelper.findChild(activityItem.rootGo, "#go_store").transform
	self.activityDungeonNodeItem.store_txtCurrencyCount = gohelper.findChildText(activityItem.rootGo, "#go_store/#txt_currencycount")
	self.activityDungeonNodeItem.store_goRemainTime = gohelper.findChild(activityItem.rootGo, "#go_store/#go_remaintime")
	self.activityDungeonNodeItem.store_txtRemainTime = gohelper.findChildText(activityItem.rootGo, "#go_store/#go_remaintime/#txt_remaintime")
	self.activityDungeonNodeItem.store_click = gohelper.findChildClick(activityItem.rootGo, "#go_store/clickarea/")

	self.activityDungeonNodeItem.store_click:AddClickListener(self.onClickStore, self)

	self.activityDungeonNodeItem.store_image = gohelper.findChildImage(activityItem.rootGo, "#go_store/#simage_storebg")
	self.activityDungeonNodeItem.store_txtName = gohelper.findChildText(activityItem.rootGo, "#go_store/storename")
	self.activityDungeonNodeItem.store_imageOriginColor = self.activityDungeonNodeItem.store_image.color
	self.activityDungeonNodeItem.store_txtCurrencyCountOriginColor = self.activityDungeonNodeItem.store_txtCurrencyCount.color
	self.activityDungeonNodeItem.store_txtNameOriginColor = self.activityDungeonNodeItem.store_txtName.color
	self.activityDungeonNodeItem.lockColor = GameUtil.parseColor("#3D4B2F")
end

function VersionActivity1_2EnterView:onClickStore()
	VersionActivity1_2EnterController.instance:openActivityStoreView()
end

function VersionActivity1_2EnterView:onDestroyView()
	VersionActivity1_2EnterView.super.onDestroyView(self)
	self._simagebg:UnLoadImage()

	if self.activityDungeonNodeItem then
		self.activityDungeonNodeItem.store_click:RemoveClickListener()

		self.activityDungeonNodeItem = nil
	end
end

return VersionActivity1_2EnterView
