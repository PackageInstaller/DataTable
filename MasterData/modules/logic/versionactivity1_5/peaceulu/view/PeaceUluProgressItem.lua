-- chunkname: @modules/logic/versionactivity1_5/peaceulu/view/PeaceUluProgressItem.lua

module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluProgressItem", package.seeall)

local PeaceUluProgressItem = class("PeaceUluProgressItem", MixScrollCell)

function PeaceUluProgressItem:init(go)
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
end

function PeaceUluProgressItem:onStart()
	return
end

function PeaceUluProgressItem:onDestroyView()
	for _, item in ipairs(self._rewarditems) do
		item.simagereward:UnLoadImage()

		if item.btnclick then
			item.btnclick:RemoveClickListener()
		end
	end
end

function PeaceUluProgressItem:removeEventListeners()
	return
end

function PeaceUluProgressItem:initMo(index, mo)
	self.mo = mo
	self.index = index

	local needProgressCo = string.split(self.mo.needProgress, "#")

	self.targetNum = needProgressCo[3]
	self._txtfinished.text = self.targetNum
	self._txtnormal.text = self.targetNum

	self:rewardItem()
end

function PeaceUluProgressItem:refreshProgress()
	local alreadyGot = PeaceUluModel.instance:checkGetReward(self.mo.id)

	self:refreshRewardItems(alreadyGot)
	gohelper.setActive(self._gonormal, not alreadyGot)
	gohelper.setActive(self._gofinished, alreadyGot)
end

function PeaceUluProgressItem:rewardItem()
	local bonus = self.mo.bonus
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
		item.goalreadygot = gohelper.findChild(itemGo, "go_hasget")
		item.btnclick = gohelper.findChildButtonWithAudio(itemGo, "btn_click")
		item.go = itemGo
		item.rewardCfg = rewardInfo
		item.itemCfg, item.iconPath = ItemModel.instance:getItemConfigAndIcon(rewardInfo[1], rewardInfo[2])

		gohelper.setActive(item.go, true)
		UISpriteSetMgr.instance:setUiFBSprite(item.imagebg, "bg_pinjidi_" .. item.itemCfg.rare)
		UISpriteSetMgr.instance:setUiFBSprite(item.imagecircle, "bg_pinjidi_lanse_" .. item.itemCfg.rare)
		table.insert(self._rewarditems, item)
	end
end

function PeaceUluProgressItem:onClickRewardItem(itemCfg)
	if itemCfg then
		MaterialTipController.instance:showMaterialInfo(itemCfg[1], itemCfg[2])
	end
end

function PeaceUluProgressItem:refreshRewardItems(alreadyGot)
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

function PeaceUluProgressItem:refreshRewardUIItem(itemObj, alreadyGot)
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

							itemObj.txtrewardcount.text = "×" .. tostring(itemObj.rewardCfg[3])

							itemObj.btnclick:RemoveClickListener()
							itemObj.btnclick:AddClickListener(self.onClickRewardItem, self, itemObj.rewardCfg)
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

return PeaceUluProgressItem
