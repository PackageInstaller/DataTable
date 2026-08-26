-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_RankBonus.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_RankBonus", package.seeall)

local V3a2_BossRush_RankBonus = class("V3a2_BossRush_RankBonus", ListScrollCellExtend)

function V3a2_BossRush_RankBonus:onInitView()
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

function V3a2_BossRush_RankBonus:addEvents()
	return
end

function V3a2_BossRush_RankBonus:removeEvents()
	return
end

function V3a2_BossRush_RankBonus:_editableInitView()
	gohelper.setActive(self._gorewardtemplate.gameObject, false)

	self.rewardItemList = self:getUserDataTb_()
end

function V3a2_BossRush_RankBonus:_editableAddEvents()
	return
end

function V3a2_BossRush_RankBonus:_editableRemoveEvents()
	return
end

function V3a2_BossRush_RankBonus:onUpdateMO(mo, view)
	self._mo = mo
	self._view = view

	if self._mo.isNoraml then
		self:_refreshLine()
		self:_refreshBonus()
	else
		self:_refreshLock()
	end
end

function V3a2_BossRush_RankBonus:_refreshLine()
	local level = self._mo.config.playerLevel
	local curRank = V3a2_BossRushModel.instance:getRank()
	local preRank = self._mo.preRank
	local progress = 0
	local midRank = level - preRank

	progress = level <= curRank and 1 or curRank - preRank <= 0 and 0 or (curRank - preRank) / midRank
	self._imageline.fillAmount = Mathf.Clamp(progress, 0, 1)

	if progress < 1 then
		if not V3a2BossRushEnum.RankLv.Gray then
			local status = V3a2BossRushEnum.RankLv.Light

			UISpriteSetMgr.instance:setV1a4BossRushSprite(self._imagestatus, status.iconStatus)
			gohelper.setActive(self._gonextline.gameObject, false)
		end
	end
end

function V3a2_BossRush_RankBonus:_refreshBonus()
	if not string.nilorempty(self._mo.config.bonus) then
		self._rewardList = GameUtil.splitString2(self._mo.config.bonus, true, "|", "#")

		for index, rewardArr in ipairs(self._rewardList) do
			local item = self:_getBonusItem(index)
			local config, icon = ItemModel.instance:getItemConfigAndIcon(rewardArr[1], rewardArr[2])
			local isHeadIcon = false

			if config.subType == ItemEnum.SubType.Portrait then
				self._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(item.simageheadicon)

				self._liveHeadIcon:setLiveHead(config.id)

				isHeadIcon = true
			else
				item.simageIcon:LoadImage(icon)

				isHeadIcon = false
			end

			gohelper.setActive(item.simageIcon.gameObject, not isHeadIcon)
			gohelper.setActive(item.goplayericon.gameObject, isHeadIcon)

			item.txtRewardcount.text = luaLang("multiple") .. rewardArr[3]

			UISpriteSetMgr.instance:setV1a4BossRushSprite(item.imageBg, BossRushConfig.instance:getQualityBgSpriteName(config.rare))
			gohelper.setActive(item.btnClaim.gameObject, self._mo.canClaim)
			gohelper.setActive(item.gohasget.gameObject, self._mo.finishClaim)
			gohelper.setActive(item.gonormal.gameObject, true)
			gohelper.setActive(item.golock.gameObject, false)

			local alpha = self._mo.finishClaim and 0.5 or 1

			item.normalCanvasGroup.alpha = alpha
			item.txtRewardcount.color.a = alpha
		end
	end

	if self._mo.canClaim or self._mo.finishClaim then
		if not V3a2BossRushEnum.RankLv.Light then
			local status = V3a2BossRushEnum.RankLv.Gray
			local lvColor = status.txtColor

			self._txtpointvalue.color = GameUtil.parseColor(lvColor)
			self._txtpointvalue.text = string.format("Lv.%d", self._mo.config.playerLevel)

			if self._rewardList then
				if not #self._rewardList then
					local count = 0

					for i = 1, #self.rewardItemList do
						local item = self.rewardItemList[i]

						gohelper.setActive(item.go, i <= count)
					end
				end
			end
		end
	end
end

function V3a2_BossRush_RankBonus:_refreshLock()
	local item = self:_getBonusItem(1)

	gohelper.setActive(item.simageIcon.gameObject, false)
	gohelper.setActive(item.gonormal.gameObject, false)
	gohelper.setActive(item.golock.gameObject, true)
	gohelper.setActive(item.btnClaim.gameObject, false)
	gohelper.setActive(item.gohasget.gameObject, false)

	item.txtRewardcount.text = ""
	self._txtpointvalue.text = "???"

	for i = 1, #self.rewardItemList do
		local item = self.rewardItemList[i]

		gohelper.setActive(item.go, i <= 1)
	end

	self._imageline.fillAmount = 0

	ZProj.UGUIHelper.SetGrayscale(self._imagestatus.gameObject, true)
	gohelper.setActive(self._gonextline.gameObject, self._mo.isShowNextLine)
end

function V3a2_BossRush_RankBonus:_getBonusItem(index)
	local item = self.rewardItemList[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gorewardtemplate, index)

		item.go = go
		item.gonormal = gohelper.findChild(go, "#go_normal")
		item.golock = gohelper.findChild(go, "#go_lock")
		item.imageBg = gohelper.findChildImage(go, "#go_normal/image_bg")
		item.simageIcon = gohelper.findChildSingleImage(go, "#go_normal/simage_reward")
		item.gohasget = gohelper.findChild(go, "go_hasget")
		item.btnClaim = gohelper.findChildButtonWithAudio(go, "btn_claim")
		item.txtRewardcount = gohelper.findChildText(go, "image_countbg/txt_rewardcount")

		item.btnClaim:AddClickListener(self._btnClaimOnClick, self)

		item.imageIcon = gohelper.findChildImage(go, "#go_normal/simage_reward")
		item.normalCanvasGroup = gohelper.onceAddComponent(item.gonormal, typeof(UnityEngine.CanvasGroup))
		item.clickItem = gohelper.findChildButtonWithAudio(go, "#go_normal/#btn_click")

		item.clickItem:AddClickListener(self._btnItemOnClick, self, index)

		item.goplayericon = gohelper.findChild(item.gonormal, "#go_playericon")
		item.simageheadicon = gohelper.findChildSingleImage(item.gonormal, "#go_playericon/#simage_headicon")
		item.goframe = gohelper.findChild(item.gonormal, "#go_playericon/#go_frame")
		self.rewardItemList[index] = item
	end

	return item
end

function V3a2_BossRush_RankBonus:_btnClaimOnClick()
	self._view:claimRankBonus()
end

function V3a2_BossRush_RankBonus:_btnItemOnClick(index)
	local reward = self._rewardList[index]

	if not reward then
		return
	end

	MaterialTipController.instance:showMaterialInfo(reward[1], reward[2])
end

function V3a2_BossRush_RankBonus:onSelect(isSelect)
	return
end

function V3a2_BossRush_RankBonus:onDestroyView()
	for i = 1, #self.rewardItemList do
		self.rewardItemList[i].btnClaim:RemoveClickListener()
		self.rewardItemList[i].clickItem:RemoveClickListener()
		self.rewardItemList[i].simageIcon:UnLoadImage()
	end
end

return V3a2_BossRush_RankBonus
