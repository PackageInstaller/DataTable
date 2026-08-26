-- chunkname: @modules/logic/versionactivity1_4/act134/view/Activity134BonusItem.lua

module("modules.logic.versionactivity1_4.act134.view.Activity134BonusItem", package.seeall)

local Activity134BonusItem = class("Activity134BonusItem", LuaCompBase)

function Activity134BonusItem:init(go)
	self.viewGO = go
	self._txtnormal = gohelper.findChildText(self.viewGO, "normal/#txt_normal")
	self._txtfinished = gohelper.findChildText(self.viewGO, "finished/#txt_finished")
	self._goitem = gohelper.findChild(self.viewGO, "#go_item")
	self._gorewardtemplate = gohelper.findChild(self._goitem, "#reward")
	self._gonormal = gohelper.findChild(self.viewGO, "normal")
	self._gofinished = gohelper.findChild(self.viewGO, "finished")

	if self._editableInitView then
		self:_editableInitView()
	end

	self:addEventListeners()
end

function Activity134BonusItem:onStart()
	return
end

function Activity134BonusItem:onDestroyView()
	self:removeEventListeners()
end

function Activity134BonusItem:addEventListeners()
	return
end

function Activity134BonusItem:removeEventListeners()
	for _, item in ipairs(self._rewarditems) do
		item.btn:RemoveClickListener()
		item.simagereward:UnLoadImage()
	end
end

function Activity134BonusItem:initMo(index, mo)
	self.mo = mo
	self.co = mo.config
	self.index = index
	self._txtnormal.text = mo.needTokensQuantity
	self._txtfinished.text = mo.needTokensQuantity

	self:rewardItem()
end

function Activity134BonusItem:refreshProgress()
	local alreadyGot = self.mo.status == Activity134Enum.StroyStatus.Finish

	self:refreshRewardItems(alreadyGot)
	gohelper.setActive(self._gonormal, not alreadyGot)
	gohelper.setActive(self._gofinished, alreadyGot)
end

function Activity134BonusItem:rewardItem()
	local bonus = self.co.bonus
	local rewardStrList = string.split(bonus, "|")

	self._rewarditems = {}

	gohelper.setActive(self._gorewardtemplate, false)

	for i = 1, #rewardStrList do
		local rewardInfo = string.splitToNumber(rewardStrList[i], "#")
		local item = self:getUserDataTb_()
		local itemGo = gohelper.clone(self._gorewardtemplate, self._goitem, "reward_" .. tostring(i))

		item.imagebg = gohelper.findChildImage(itemGo, "image_bg")
		item.imagecircle = gohelper.findChildImage(itemGo, "image_circle")
		item.simagereward = gohelper.findChildSingleImage(itemGo, "simage_reward")
		item.txtrewardcount = gohelper.findChildText(itemGo, "txt_rewardcount")
		item.txtpointvalue = gohelper.findChildText(itemGo, "txt_pointvalue")
		item.imagereward = item.simagereward:GetComponent(gohelper.Type_Image)
		item.btn = gohelper.findChildClick(itemGo, "simage_reward")
		item.goalreadygot = gohelper.findChild(itemGo, "go_hasget")

		item.btn:AddClickListener(self.onClickItem, self, item)

		item.go = itemGo
		item.rewardCfg = rewardInfo
		item.itemCfg, item.iconPath = ItemModel.instance:getItemConfigAndIcon(rewardInfo[1], rewardInfo[2])

		gohelper.setActive(item.go, true)
		UISpriteSetMgr.instance:setUiFBSprite(item.imagebg, "bg_pinjidi_" .. item.itemCfg.rare)
		UISpriteSetMgr.instance:setUiFBSprite(item.imagecircle, "bg_pinjidi_lanse_" .. item.itemCfg.rare)
		table.insert(self._rewarditems, item)
	end
end

function Activity134BonusItem:refreshRewardItems(alreadyGot)
	for i, item in ipairs(self._rewarditems) do
		self:refreshRewardUIItem(item, alreadyGot)
	end
end

local COLOR_REWARD_GOT = Color.New(0.6941177, 0.6941177, 0.6941177, 1)
local COLOR_REWARD_NORMAL = Color.New(1, 1, 1, 1)
local COLOR_BG_GOT = Color.New(1, 1, 1, 0.5)
local COLOR_BG_NORMAL = Color.New(1, 1, 1, 1)
local COLOR_COUNT_GOT = Color.New(0.4235, 0.4235, 0.4235, 1)
local COLOR_COUNT_NORMAL = Color.New(0.9411, 0.9411, 0.9411, 1)

function Activity134BonusItem:refreshRewardUIItem(itemObj, alreadyGot)
	if alreadyGot then
		if not COLOR_REWARD_GOT then
			local rewardColor = COLOR_REWARD_NORMAL

			if alreadyGot then
				if not COLOR_BG_GOT then
					local bgColor = COLOR_BG_NORMAL

					if alreadyGot then
						if not COLOR_COUNT_GOT then
							itemObj.imagereward.color = rewardColor
							itemObj.imagebg.color = bgColor
							itemObj.txtrewardcount.color = COLOR_COUNT_NORMAL

							itemObj.simagereward:LoadImage(itemObj.iconPath)

							itemObj.txtrewardcount.text = tostring(itemObj.rewardCfg[3])

							gohelper.setActive(itemObj.goalreadygot, alreadyGot)

							local rewardAnim = itemObj.go:GetComponent(typeof(UnityEngine.Animator))

							if alreadyGot then
								rewardAnim:Play("dungeoncumulativerewardsitem_received")
							end
						end
					end
				end
			end
		end
	end
end

function Activity134BonusItem:onClickItem(itemObj)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	MaterialTipController.instance:showMaterialInfo(itemObj.rewardCfg[1], itemObj.rewardCfg[2])
end

return Activity134BonusItem
