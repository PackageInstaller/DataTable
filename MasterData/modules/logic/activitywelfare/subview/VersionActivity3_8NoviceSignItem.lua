-- chunkname: @modules/logic/activitywelfare/subview/VersionActivity3_8NoviceSignItem.lua

module("modules.logic.activitywelfare.subview.VersionActivity3_8NoviceSignItem", package.seeall)

local VersionActivity3_8NoviceSignItem = class("VersionActivity3_8NoviceSignItem", LuaCompBase)

function VersionActivity3_8NoviceSignItem:init(go, index)
	self._go = go
	self._index = index
	self._gonormal = gohelper.findChild(go, "go_normal")
	self._gonormalcontent = gohelper.findChild(go, "go_normal/go_normalcontent")
	self._gonormalicon1 = gohelper.findChild(go, "go_normal/go_normalcontent/go_normalicon1")
	self._imagenormalrare1 = gohelper.findChildImage(go, "go_normal/go_normalcontent/go_normalicon1/image_normalrare1")
	self._simagenormalreward1 = gohelper.findChildSingleImage(go, "go_normal/go_normalcontent/go_normalicon1/simage_normalreward1")
	self._txtnormalrewardnum1 = gohelper.findChildText(go, "go_normal/go_normalcontent/go_normalicon1/txt_normalrewardnum1")
	self._gonormalicon2 = gohelper.findChild(go, "go_normal/go_normalcontent/go_normalicon2")
	self._imagenormalrare2 = gohelper.findChildImage(go, "go_normal/go_normalcontent/go_normalicon2/image_normalrare2")
	self._simagenormalreward2 = gohelper.findChildSingleImage(go, "go_normal/go_normalcontent/go_normalicon2/simage_normalreward2")
	self._txtnormalrewardnum2 = gohelper.findChildText(go, "go_normal/go_normalcontent/go_normalicon2/txt_normalrewardnum2")
	self._gosp = gohelper.findChild(go, "go_sp")
	self._gospcontent = gohelper.findChild(go, "go_sp/go_spcontent")
	self._gospicon1 = gohelper.findChild(go, "go_sp/go_spcontent/go_spicon1")
	self._simagespreward1 = gohelper.findChildSingleImage(go, "go_sp/go_spcontent/go_spicon1/simage_spreward1")
	self._txtsprewardnum1 = gohelper.findChildText(go, "go_sp/go_spcontent/go_spicon1/txt_sprewardnum1")
	self._gospicon2 = gohelper.findChild(go, "go_sp/go_spcontent/go_spicon2")
	self._simagespreward2 = gohelper.findChildSingleImage(go, "go_sp/go_spcontent/go_spicon2/simage_spreward2")
	self._txtsprewardnum2 = gohelper.findChildText(go, "go_sp/go_spcontent/go_spicon2/txt_sprewardnum2")
	self._gofinal = gohelper.findChild(go, "go_final")
	self._imagefinalrare = gohelper.findChildImage(go, "go_final/image_finalrare")
	self._simagefinalreward = gohelper.findChildSingleImage(go, "go_final/simage_finalreward")
	self._gofinalbg = gohelper.findChild(go, "go_final/go_finalbg")
	self._godate = gohelper.findChild(go, "go_date")
	self._gotomorrowtag = gohelper.findChild(go, "go_tomorrowtag")
	self._gotodaynormalbg = gohelper.findChild(go, "go_todaynormalbg")
	self._gotodayspbg = gohelper.findChild(go, "go_todayspbg")
	self._gotag = gohelper.findChild(go, "go_tag")
	self._txttag = gohelper.findChildText(go, "go_tag/txt_tag")
	self._gonormalget = gohelper.findChild(go, "go_normalget")
	self._gospget = gohelper.findChild(go, "go_spget")
	self._finalget = gohelper.findChild(go, "go_finalget")
	self._txtdate = gohelper.findChildText(go, "go_date/txt_date")

	self:_initItem()
	self:_addEvents()
end

function VersionActivity3_8NoviceSignItem:_initItem()
	self._actId = ActivityEnum.Activity.NoviceSign
	self._normalBgGetClick = gohelper.getClickWithAudio(self._gotodaynormalbg)
	self._spBgGetClick = gohelper.getClickWithAudio(self._gotodayspbg)
	self._finalBgGetClick = gohelper.getClickWithAudio(self._gofinalbg)
	self._normalItemClick1 = gohelper.getClickWithAudio(self._simagenormalreward1.gameObject)
	self._normalItemClick2 = gohelper.getClickWithAudio(self._simagenormalreward2.gameObject)
	self._spItemClick1 = gohelper.getClickWithAudio(self._simagespreward1.gameObject)
	self._spItemClick2 = gohelper.getClickWithAudio(self._simagespreward2.gameObject)
	self._canvasdate = self._godate:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._cannormalcontent = self._gonormalcontent:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._anim = self._go:GetComponent(typeof(UnityEngine.Animator))
	self._anim.enabled = false

	gohelper.setActive(self._go, false)

	local act101Cos = ActivityConfig.instance:getNorSignActivityCos(self._actId)

	self._maxDay = #act101Cos or 0
	self._rewardTab = self:getUserDataTb_()
end

function VersionActivity3_8NoviceSignItem:_addEvents()
	self._normalBgGetClick:AddClickListener(self._onGetBonusClick, self)
	self._spBgGetClick:AddClickListener(self._onGetBonusClick, self)
	self._finalBgGetClick:AddClickListener(self._onGetBonusClick, self)
	self._normalItemClick1:AddClickListener(self._onRewardItemClick, self, 1)
	self._normalItemClick2:AddClickListener(self._onRewardItemClick, self, 2)
	self._spItemClick1:AddClickListener(self._onRewardItemClick, self, 1)
	self._spItemClick2:AddClickListener(self._onRewardItemClick, self, 2)
end

function VersionActivity3_8NoviceSignItem:_removeEvents()
	self._normalBgGetClick:RemoveClickListener()
	self._spBgGetClick:RemoveClickListener()
	self._finalBgGetClick:RemoveClickListener()
	self._normalItemClick1:RemoveClickListener()
	self._normalItemClick2:RemoveClickListener()
	self._spItemClick1:RemoveClickListener()
	self._spItemClick2:RemoveClickListener()
end

function VersionActivity3_8NoviceSignItem:_onGetBonusClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(ActivityEnum.Activity.NoviceSign, self._index)

	if not couldGet then
		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(ActivityEnum.Activity.NoviceSign, self._index)
end

function VersionActivity3_8NoviceSignItem:_onRewardItemClick(index)
	local signCo = ActivityConfig.instance:getNorSignActivityCo(ActivityEnum.Activity.NoviceSign, self._index)
	local rewards = string.split(signCo.v2Bonus, "|")

	if not rewards or not rewards[index] then
		return
	end

	local props = string.splitToNumber(rewards[index], "#")

	MaterialTipController.instance:showMaterialInfo(tonumber(props[1]), tonumber(props[2]))
end

function VersionActivity3_8NoviceSignItem:refresh(co)
	self._co = co

	self:_refreshItem()
	TaskDispatcher.runDelay(self._playAnimation, self, self._index * 0.03)
end

function VersionActivity3_8NoviceSignItem:_refreshItem()
	self._txtdate.text = string.format("%02d", self._index)

	local totalday = ActivityType101Model.instance:getType101LoginCount(ActivityEnum.Activity.NoviceSign)

	gohelper.setActive(self._gotag, not LuaUtil.isEmptyStr(self._co.clientDisplayTxt))

	self._txttag.text = not LuaUtil.isEmptyStr(self._co.clientDisplayTxt) and luaLang(self._co.clientDisplayTxt) or ""

	local isTomorrow = self._index == totalday + 1

	gohelper.setActive(self._gotomorrowtag, isTomorrow)

	local dateColor = isTomorrow and "#ADA697" or "#FFFFFF"

	SLFramework.UGUI.GuiHelper.SetColor(self._txtdate, dateColor)

	local isFinal = self._index == self._maxDay
	local rewardGet = ActivityType101Model.instance:isType101RewardGet(ActivityEnum.Activity.NoviceSign, self._index)

	self._canvasdate.alpha = rewardGet and 0.8 or 1

	gohelper.setActive(self._finalget, rewardGet and isFinal)

	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(ActivityEnum.Activity.NoviceSign, self._index)

	gohelper.setActive(self._gotodaynormalbg, couldGet)

	self._cannormalcontent.alpha = rewardGet and 0.8 or 1

	local isSp = self._co.clientDisplayType == 1

	gohelper.setActive(self._gonormalget, rewardGet and not isSp and not isFinal)
	gohelper.setActive(self._gospget, rewardGet and isSp and not isFinal)
	gohelper.setActive(self._gofinal, isFinal)
	gohelper.setActive(self._gonormal, not isSp and not isFinal)
	gohelper.setActive(self._gosp, isSp and not isFinal)

	local signCo = ActivityConfig.instance:getNorSignActivityCo(ActivityEnum.Activity.NoviceSign, self._index)

	if not isFinal then
		local rewards = string.split(signCo.v2Bonus, "|")

		gohelper.setActive(self._gonormalicon1, not isSp and #rewards >= 1)
		gohelper.setActive(self._gonormalicon2, not isSp and #rewards >= 2)

		for i = 1, #rewards do
			local itemCos = string.splitToNumber(rewards[i], "#")
			local itemCfg, icon = ItemModel.instance:getItemConfigAndIcon(itemCos[1], itemCos[2], true)

			if not itemCfg.rare then
				if isSp then
					self["_simagespreward" .. i]:LoadImage(icon)

					self["_txtsprewardnum" .. i].text = luaLang("multiple") .. itemCos[3]
				else
					self["_simagenormalreward" .. i]:LoadImage(icon)
					UISpriteSetMgr.instance:setSeasonSprite(self["_imagenormalrare" .. i], "img_pz_" .. itemCfg.rare, true)

					self["_txtnormalrewardnum" .. i].text = itemCos[3]
				end
			end
		end
	else
		local props = string.splitToNumber(signCo.v2Bonus, "#")
		local _, icon = ItemModel.instance:getItemConfigAndIcon(props[1], props[2], true)

		self._simagefinalreward:LoadImage(icon)

		local imgComp = self._simagefinalreward:GetComponent(gohelper.Type_Image)

		if imgComp then
			ZProj.UGUIHelper.SetColorAlpha(imgComp, rewardGet and 0.8 or 1)
		end
	end
end

function VersionActivity3_8NoviceSignItem:_playAnimation()
	gohelper.setActive(self._go, true)

	self._anim.enabled = true
end

function VersionActivity3_8NoviceSignItem:destroy()
	self:_removeEvents()
	TaskDispatcher.cancelTask(self._playAnimation, self)
end

return VersionActivity3_8NoviceSignItem
