-- chunkname: @modules/logic/sp01/act208/view/V2a9_Act208MainView.lua

module("modules.logic.sp01.act208.view.V2a9_Act208MainView", package.seeall)

local V2a9_Act208MainView = class("V2a9_Act208MainView", BaseView)

function V2a9_Act208MainView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/Title/#simage_Title")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a9_Act208MainView:addEvents()
	self.addEventCb(self, Act208Controller.instance, Act208Event.onGetInfo, self.refreshState, self)
	self.addEventCb(self, Act208Controller.instance, Act208Event.onGetBonus, self.refreshState, self)
end

function V2a9_Act208MainView:removeEvents()
	self.removeEventCb(self, Act208Controller.instance, Act208Event.onGetInfo, self.refreshState, self)
	self.removeEventCb(self, Act208Controller.instance, Act208Event.onGetBonus, self.refreshState, self)
end

function V2a9_Act208MainView:_editableInitView()
	self._goRewardParent = gohelper.findChild(self.viewGO, "Root/reward")

	local childCount = self._goRewardParent.transform.childCount

	self._rewardItemList = {}

	for i = 1, childCount do
		local childTran = self._goRewardParent.transform:GetChild(i - 1)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(childTran.gameObject, V2a9_Act208RewardItem)

		table.insert(self._rewardItemList, item)
	end
end

function V2a9_Act208MainView:onUpdateParam()
	return
end

function V2a9_Act208MainView:onOpen()
	local param = self.viewParam

	self.actId = param.actId

	local channelId = Act208Helper.getCurPlatformType()

	Act208Controller.instance:getActInfo(self.actId, channelId)
	self:_checkParent()
	self:refreshUI()
end

function V2a9_Act208MainView:_checkParent()
	local parentGO = self.viewParam.parent

	if parentGO then
		gohelper.addChild(parentGO, self.viewGO)
	end
end

function V2a9_Act208MainView:refreshUI()
	local actId = self.actId
	local bonusConfigList = Act208Config.instance:getBonusListById(actId)

	for _, bonusConfig in ipairs(bonusConfigList) do
		local item = self._rewardItemList[bonusConfig.id]

		if item ~= nil then
			item:setData(actId, bonusConfig)
		end
	end
end

function V2a9_Act208MainView:refreshState(activityId, id)
	local actId = self.actId

	if activityId ~= actId then
		return
	end

	local infoMo = Act208Model.instance:getInfo(activityId)

	if not infoMo then
		return
	end

	if id ~= nil then
		local bonusMo = infoMo.bonusDic[id]
		local item = self._rewardItemList[id]

		item:setState(bonusMo)
	else
		for _, bonusMo in ipairs(infoMo.bonusList) do
			local item = self._rewardItemList[bonusMo.id]

			item:setState(bonusMo)
		end
	end
end

function V2a9_Act208MainView:onClose()
	return
end

function V2a9_Act208MainView:onDestroyView()
	return
end

return V2a9_Act208MainView
