-- chunkname: @modules/logic/bossrush/view/v2a9/V2a9_BossRushMainView.lua

module("modules.logic.bossrush.view.v2a9.V2a9_BossRushMainView", package.seeall)

local V2a9_BossRushMainView = class("V2a9_BossRushMainView", V1a4_BossRushMainView)

function V2a9_BossRushMainView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "LimitTime/#txt_LimitTime")
	self._btnStore = gohelper.findChildButtonWithAudio(self.viewGO, "Store/#btn_Store")
	self._simageProp = gohelper.findChildSingleImage(self.viewGO, "Store/#btn_Store/#simage_Prop")
	self._txtNum = gohelper.findChildText(self.viewGO, "Store/#btn_Store/#txt_Num")
	self._btnAchievement = gohelper.findChildButtonWithAudio(self.viewGO, "TopRight/#btn_Achievement")
	self._txtAchievement = gohelper.findChildText(self.viewGO, "TopRight/#txt_Achievement")
	self._goStoreTip = gohelper.findChild(self.viewGO, "Store/image_Tips")
	self._txtStore = gohelper.findChildText(self.viewGO, "Store/#btn_Store/txt_Store")
	self._txtActDesc = gohelper.findChildText(self.viewGO, "txtDescr")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a9_BossRushMainView:addEvents()
	V2a9_BossRushMainView.super.addEvents(self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V2a9_BossRushMainView:removeEvents()
	V2a9_BossRushMainView.super.removeEvents(self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V2a9_BossRushMainView:_onCloseViewFinish(viewName)
	if viewName == ViewName.VersionActivity2_9DungeonMapView or viewName == ViewName.OdysseyDungeonView then
		local dataList = BossRushModel.instance:getStagesInfo()

		for i, mo in ipairs(dataList) do
			if not self._itemList[i] then
				local item = self:_create_V2a9_BossRushMainItem()

				self._itemList[i]._index = i

				self._itemList[i]:returnPlayAnim(true)

				self._itemList[i] = self._itemList[i]
			end
		end
	end
end

function V2a9_BossRushMainView:_editableInitView()
	V2a9_BossRushMainView.super._editableInitView(self)

	self._goContent = gohelper.findChild(self.viewGO, "StageItems")

	V1a6_BossRush_StoreModel.instance:readAllStoreGroupNewData()
	V1a6_BossRush_StoreModel.instance:checkStoreNewGoods()
	ActivityEnterMgr.instance:enterActivity(BossRushConfig.instance:getActivityId())
end

function V2a9_BossRushMainView:_create_V2a9_BossRushMainItem()
	local itemClass = V2a9_BossRushMainItem
	local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrushmainitem, self._goContent, itemClass.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)
end

function V2a9_BossRushMainView:_initItemList(dataList)
	if self._itemList then
		return
	end

	self._itemList = {}

	for i, mo in ipairs(dataList) do
		local item = self:_create_V2a9_BossRushMainItem()

		item._index = i

		item:setData(mo, true)
		table.insert(self._itemList, item)
	end
end

function V2a9_BossRushMainView:_refreshRight()
	local dataList = BossRushModel.instance:getStagesInfo()

	self:_initItemList(dataList)
end

function V2a9_BossRushMainView:_refreshLeftBottom()
	return
end

return V2a9_BossRushMainView
