-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_ActEnterView.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_ActEnterView", package.seeall)

local V3a9_BossRush_ActEnterView = class("V3a9_BossRush_ActEnterView", V3a9_BossRush_NormalEnterView)

function V3a9_BossRush_ActEnterView:_editableInitView()
	self._goStoreTip = gohelper.findChild(self.viewGO, "Right/Store/image_Tips")
	self._txtStore = gohelper.findChildText(self.viewGO, "Right/Store/#btn_Store/txt_Store")
	self._txtActDesc = gohelper.findChildText(self.viewGO, "Left/txtDescr")

	local nameCn, nameEn = V1a6_BossRush_StoreModel.instance:getStoreGroupName(StoreEnum.BossRushStore.ManeTrust)

	self._txtStore.text = nameCn
	self._itemObjects = {}

	local actId = V3a9_BossRushModel.instance:getActModeActId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if actInfoMo then
		self._txtActDesc.text = actInfoMo.config.actDesc

		local rewards = GameUtil.splitString2(actInfoMo.config.activityBonus, true)

		if rewards then
			for i, reward in ipairs(rewards) do
				local item = self._itemObjects[i]

				if not item then
					item = IconMgr.instance:getCommonPropItemIcon(self._gorewardcontent)

					table.insert(self._itemObjects, item)
				end

				item:setMOValue(reward[1], reward[2], 1)
				item:isShowCount(false)
			end
		end

		if actInfoMo.config.openId and actInfoMo.config.openId > 0 then
			self._txtTips.text = OpenHelper.getActivityUnlockTxt(actInfoMo.config.openId)
		end
	end

	self:_initRank()

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function V3a9_BossRush_ActEnterView:onStart()
	V3a9_BossRush_ActEnterView.super.onStart(self)

	local actId = BossRushConfig.instance:getActivityId()
	local key = string.format("%s_%s", V3a9BossRushEnum.PlayerPrefKey.FirstEnterAnim, actId)
	local value = GameUtil.playerPrefsGetNumberByUserId(key, 0)
	local aniName = "open"

	if value == 0 then
		GameUtil.playerPrefsSetNumberByUserId(key, 1)

		aniName = "firstopen"
	end

	self._animator:Play(aniName, 0, 0)
end

function V3a9_BossRush_ActEnterView:_refreshTime()
	local actId = V3a9_BossRushModel.instance:getActModeActId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		end
	end
end

return V3a9_BossRush_ActEnterView
