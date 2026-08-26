-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_BonusItem.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_BonusItem", package.seeall)

local V3a9_BossRush_BonusItem = class("V3a9_BossRush_BonusItem", ListScrollCellExtend)

function V3a9_BossRush_BonusItem:onInitView()
	self._gorewards = gohelper.findChild(self.viewGO, "#go_rewards")
	self._gorewardtemplate = gohelper.findChild(self.viewGO, "#go_rewards/#go_reward_template")
	self._goline = gohelper.findChild(self.viewGO, "bottom/#go_line")
	self._imageline = gohelper.findChildImage(self.viewGO, "bottom/#go_line/#image_line")
	self._gonextline = gohelper.findChildImage(self.viewGO, "bottom/#go_line/#go_nextline")
	self._imagestatus = gohelper.findChildImage(self.viewGO, "bottom/#image_status")
	self._txtpointvalue = gohelper.findChildText(self.viewGO, "bottom/#txt_pointvalue")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_BonusItem:addEvents()
	return
end

function V3a9_BossRush_BonusItem:removeEvents()
	return
end

function V3a9_BossRush_BonusItem:refresh(data)
	if data then
		self:onUpdateMO(data)
		gohelper.setActive(self.viewGO, true)
	else
		self.data = nil

		gohelper.setActive(self.viewGO, false)
	end
end

function V3a9_BossRush_BonusItem:_refreshLine()
	local state = MileStoneUtil.getBonusState(self.config.milestoneId, self.config.bonusId)
	local progress = 1
	local iconStatus = V3a2BossRushEnum.RankLv.Light.iconStatus

	if state == MileStoneEnum.BonusState.CanNotGet then
		iconStatus = V3a2BossRushEnum.RankLv.Gray.iconStatus

		local preMo = MileStoneModel.instance:getDataById(self.config.bonusId - 1)

		if preMo then
			local preCo = MileStoneConfig.instance:getBonusConfig(self.config.milestoneId, self.config.bonusId - 1)

			if preCo then
				if not preCo.needProgress then
					local preNeedProgress = 0
					local needProgress = self.config.needProgress
					local curProgress = MileStoneUtil.getMileStoneProgress(self.config.milestoneId)

					progress = (curProgress - preNeedProgress) / (needProgress - preNeedProgress)
				end
			end
		else
			progress = 0
		end
	end

	self._imageline.fillAmount = Mathf.Clamp(progress, 0, 1)

	if state == MileStoneEnum.BonusState.CanNotGet then
		if not V3a2BossRushEnum.RankLv.Gray then
			local rankLv = V3a2BossRushEnum.RankLv.Light

			UISpriteSetMgr.instance:setV1a4BossRushSprite(self._imagestatus, rankLv.iconStatus)
			gohelper.setActive(self._gonextline.gameObject, false)
		end
	end
end

function V3a9_BossRush_BonusItem:onUpdateMO(data)
	self.data = data
	self.config = data:getConfig()

	self:refreshReward()
	self:refreshChapter()
	self:_refreshLine()
end

function V3a9_BossRush_BonusItem:refreshReward()
	local config = self.config
	local rewardList = GameUtil.splitString2(config.bonus, true) or {}

	self._rewardItems = self._rewardItems or {}

	for i = 1, math.max(#self._rewardItems, #rewardList) do
		local reward = rewardList[i]
		local item = self:_getBonusItem(i)

		item.data = reward

		self:refreshRewardItem(item, reward)
	end

	gohelper.setActive(self._gospecial, config.special == 1)
end

function V3a9_BossRush_BonusItem:_getBonusItem(index)
	local item = self._rewardItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gorewardtemplate, index)

		item.go = go
		item.gonormal = gohelper.findChild(go, "#go_normal")
		item.golock = gohelper.findChild(go, "#go_lock")
		item.imageBg = gohelper.findChildImage(go, "#go_normal/image_bg")
		item.goIcon = gohelper.findChild(go, "#go_normal/simage_reward")
		item.gohasget = gohelper.findChild(go, "go_hasget")
		item.btnClaim = gohelper.findChildButtonWithAudio(go, "btn_claim")
		item.txtRewardcount = gohelper.findChildText(go, "image_countbg/txt_rewardcount")

		item.btnClaim:AddClickListener(self.onClickItem, self, item)

		item.normalCanvasGroup = gohelper.onceAddComponent(item.gonormal, typeof(UnityEngine.CanvasGroup))
		item.clickItem = gohelper.findChildButtonWithAudio(go, "#go_normal/#btn_click")

		item.clickItem:AddClickListener(self.onClickItem, self, item)

		self._rewardItems[index] = item
	end

	return item
end

local COLOR_REWARD_NORMAL = Color.New(1, 1, 1, 1)

function V3a9_BossRush_BonusItem:refreshRewardItem(item, data)
	item.data = data

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local state = MileStoneUtil.getBonusState(self.config.milestoneId, self.config.bonusId)
	local itemCfg, iconPath = ItemModel.instance:getItemConfigAndIcon(data[1], data[2])

	if itemCfg then
		UISpriteSetMgr.instance:setUiFBSprite(item.imageBg, "bg_pinjidi_" .. itemCfg.rare)
	end

	item.itemIcon = item.itemIcon or IconMgr.instance:getCommonPropItemIcon(item.goIcon)

	item.itemIcon:setMOValue(data[1], data[2], data[3], nil, true)

	if data[1] == MaterialEnum.MaterialType.Equip then
		item.itemIcon._equipIcon._overrideLoadIconFunc(item.itemIcon._equipIcon, EquipHelper.getEquipDefaultIconLoadPath, item.itemIcon._equipIcon)
		item.itemIcon._equipIcon:_loadIconImage()
		gohelper.setActive(item.itemIcon._equipIcon._gonum, false)
	end

	item.itemIcon:isShowQuality(false)
	item.itemIcon:isShowCount(false)
	item.itemIcon:hideEquipLvAndBreak(true)

	local lang = luaLang("v3a9_bossrush_reward")

	item.txtRewardcount.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, luaLang("multiple"), tostring(data[3]))

	gohelper.setActive(item.gohasget, state == MileStoneEnum.BonusState.HasGet)

	local canGet = state == MileStoneEnum.BonusState.CanGet

	gohelper.setActive(item.btnClaim, canGet)
end

function V3a9_BossRush_BonusItem:onClickItem(item)
	if not self.config then
		return
	end

	local state = MileStoneUtil.getBonusState(self.config.milestoneId, self.config.bonusId)

	if state == MileStoneEnum.BonusState.CanGet then
		MileStoneRpc.instance:sendGetMilestoneBonusRequest(self.config.milestoneId)
	elseif item.data then
		MaterialTipController.instance:showMaterialInfo(item.data[1], item.data[2])
	end
end

function V3a9_BossRush_BonusItem:refreshChapter()
	local state = MileStoneUtil.getBonusState(self.config.milestoneId, self.config.bonusId)
	local isNotFinish = state == MileStoneEnum.BonusState.CanNotGet

	self._txtpointvalue.text = BossRushConfig.instance:getScoreStr(self.config.needProgress)

	local color = isNotFinish and "#838383" or "#EB893E"

	self._txtpointvalue.color = GameUtil.parseColor(color)

	gohelper.setActive(self.goScoreBg, not isNotFinish)
	gohelper.setActive(self.goScoreBgGrey, isNotFinish)
end

function V3a9_BossRush_BonusItem:_editableInitView()
	gohelper.setActive(self._gorewardtemplate.gameObject, false)
end

function V3a9_BossRush_BonusItem:onDestroyView()
	if self._rewardItems then
		for _, item in pairs(self._rewardItems) do
			item.btnClaim:RemoveClickListener()
			item.clickItem:RemoveClickListener()
		end

		self._rewardItems = nil
	end
end

return V3a9_BossRush_BonusItem
