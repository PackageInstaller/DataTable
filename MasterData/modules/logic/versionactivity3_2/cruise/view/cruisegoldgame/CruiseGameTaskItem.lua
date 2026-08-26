-- chunkname: @modules/logic/versionactivity3_2/cruise/view/cruisegoldgame/CruiseGameTaskItem.lua

module("modules.logic.versionactivity3_2.cruise.view.cruisegoldgame.CruiseGameTaskItem", package.seeall)

local CruiseGameTaskItem = class("CruiseGameTaskItem", SimpleListItem)

function CruiseGameTaskItem:onInit(viewGO)
	self.go_icon = gohelper.findChild(viewGO, "hori/#go_reward/go_icon")
	self.go_iconbg = gohelper.findChildImage(viewGO, "hori/#go_reward/#go_iconbg")
	self.go_receive = gohelper.findChild(viewGO, "hori/#go_reward/go_receive")
	self.go_canget = gohelper.findChild(viewGO, "hori/#go_reward/go_canget")
	self.mask = gohelper.findChild(viewGO, "mask")
	self.stateHasGet = gohelper.findChild(viewGO, "hori/#go_reward/#image_status_hasget")
	self.stateCanGet = gohelper.findChild(viewGO, "hori/#go_reward/#image_status_canget")
	self.stateLock = gohelper.findChild(viewGO, "hori/#go_reward/#image_status_lock")
	self.txt_pointvalue_HasGet = gohelper.findChildTextMesh(self.stateHasGet, "txt_pointvalue")
	self.txt_pointvalue_CanGet = gohelper.findChildTextMesh(self.stateCanGet, "txt_pointvalue")
	self.txt_pointvalue_Lock = gohelper.findChildTextMesh(self.stateLock, "txt_pointvalue")
	self.coinNormal = gohelper.findChild(viewGO, "#image_bg")
	self.coinGray = gohelper.findChild(viewGO, "#image_graybg")
	self.textCoinNormal = gohelper.findChildTextMesh(viewGO, "#image_bg/#txt_value")
	self.textCoinGray = gohelper.findChildTextMesh(viewGO, "#image_graybg/#txt_value")
end

function CruiseGameTaskItem:onAddListeners()
	return
end

function CruiseGameTaskItem:onRemoveListeners()
	return
end

function CruiseGameTaskItem:onItemShow(param)
	self.cfg = param.cfg
	self.isLock = param.isLock
	self.isReceive = param.isReceive
	self.canGet = param.canGet
	self.bonus = Activity218Config.instance:getBonus(self.cfg.activityId, self.cfg.rewardId)[1]

	gohelper.setActive(self.mask, self.cfg.isSpBonus)
	gohelper.setActive(self.stateHasGet, self.isReceive)
	gohelper.setActive(self.stateCanGet, self.canGet)
	gohelper.setActive(self.stateLock, self.isLock)
	gohelper.setActive(self.go_canget, self.canGet)
	gohelper.setActive(self.go_receive, self.isReceive)
	gohelper.setActive(self.coinNormal, not self.isLock)
	gohelper.setActive(self.coinGray, self.isLock)

	local count = luaLang("multiple") .. self.bonus[3]

	self.txt_pointvalue_HasGet.text = count
	self.txt_pointvalue_CanGet.text = count
	self.txt_pointvalue_Lock.text = count
	self.textCoinNormal.text = self.cfg.coinNum
	self.textCoinGray.text = self.cfg.coinNum

	local itemCfg, _ = ItemModel.instance:getItemConfigAndIcon(self.bonus[1], self.bonus[2])

	UISpriteSetMgr.instance:setV3a2CruiseSprite(self.go_iconbg, "goldschedule_rare_" .. itemCfg.rare)

	self.item = self.item or IconMgr.instance:getCommonPropItemIcon(self.go_icon)

	self.item:onUpdateMO({
		materilType = self.bonus[1],
		materilId = self.bonus[2],
		quantity = self.bonus[3]
	})
	self.item:isShowCount(false)
	self.item:isShowQuality(false)
	self.item:setInterceptClick(self.onClickItem, self)
end

function CruiseGameTaskItem:onClickItem()
	if self.canGet then
		Activity218Controller.instance:sendAct218AcceptRewardRequest()

		return true
	end

	return false
end

return CruiseGameTaskItem
