-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/head/HeadCell.lua

module("logic.extensions.material.proxy.HeadCell", package.seeall)

local HeadCell = class("HeadCell", MaterialCell)

function HeadCell:ctor(target)
	HeadCell.super.ctor(self, target)

	self.iconBg = goutil.findChild(self.target, "ImgBg")
	self.icon = goutil.findChild(self.target, "icon")
	self.frame = goutil.findChild(self.target, "frame")
	self.vipGo = goutil.findChild(self.target, "vip")
	self.vipLvl = goutil.findChild(self.target, "vip/level"):GetComponent(ComponentType.UIImgNumeralText)
	self.isBgActive = true
	self.withTag = goutil.findChild(self.target, "withTag")

	GameUtil.addClickHandler(self.target, self._OnClick, self)
end

function HeadCell:_OnClick()
	print(">>>>>>>>>>>HeadCell cell click")
	GameUtil.callBack(self.callback, self)

	if self.autoTips then
		CommonTipsMgr.instance:openMaterialTips(self.icon, self.type, self.id, 0)
	end
end

function HeadCell:setData(data)
	HeadCell.super.setData(self, data)
end

function HeadCell:setCfgData(cfg)
	HeadCell.super.setCfgData(self, cfg)
	self.icon:SetActive(false)
	GameUtil.SetActive(self.icon, false)
	self:setVipLvl(0)
	self:setBgActive(self.isBgActive)
	GameUtil.setUIImageSpriteIdx(self.iconBg, 0)

	self.loader = RoleObjectPool.instance:removeHead(self.loader)

	MaterialMgr.clearIcon(self.icon)

	if cfg then
		GameUtil.setUIImageSpriteIdx(self.iconBg, 1 + (cfg.quality or 0))
		GameUtil.SetActive(self.icon, true)

		if checknumber(cfg.isSpine) == 1 then
			self.loader = RoleObjectPool.instance:addHeadToParent(self.loader, self.type, cfg.id, self.icon)
		else
			MaterialMgr.setIcon(self.icon, self.type, cfg.id)
		end
	end

	self:setWithTag(0)
end

function HeadCell:setBgActive(boo)
	self.isBgActive = boo

	GameUtil.SetActive(self.iconBg, boo)
end

function HeadCell:setHeadFrameById(cfgId, callback)
	cfgId = checknumber(cfgId)

	if cfgId > 0 then
		self.autoTips = false

		local proxy = MaterialMgr.setCell(MatType.HeadFrame, cfgId, self.frame)

		if proxy then
			proxy.binder:setBgActive(false)
			proxy.binder:setAutoTips(false)
			proxy:callWhenCom(callback)
		else
			GameUtil.callBack(callback)
		end
	else
		GameUtil.callBack(callback)
	end
end

function HeadCell:setVipLvl(lvl)
	lvl = checknumber(lvl)

	if lvl <= 0 then
		GameUtil.SetActive(self.vipGo, false)
	else
		GameUtil.SetActive(self.vipGo, true)

		if self.vipLvl then
			self.vipLvl:SetNum(lvl)
		end
	end
end

function HeadCell:addMyVipLvlupEvent()
	GlobalDispatcher:addListener(GlobalNotify.BroadcastCurVipLevel, self.updateState, self)
end

function HeadCell:updateState()
	local vipLv = RoleModel.instance:getVipLvl()

	self:setVipLvl(vipLv)
end

function HeadCell:setWithTag(state)
	GameUtil.SetActive(self.withTag, state == 1)
end

function HeadCell:dispose()
	HeadCell.super.dispose(self)
	MaterialMgr.resetAll(self.frame)
	MaterialMgr.clearIcon(self.icon)
	Framework.TransformUtil.SetLocalScale(self.icon.transform, 1, 1, 1)
	Framework.TransformUtil.SetLocalPos(self.icon.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalRotation(self.icon.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(self.target.transform, 1, 1, 1)
	Framework.TransformUtil.SetLocalPos(self.target.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalRotation(self.target.transform, 0, 0, 0)

	self.isBgActive = true
	self.loader = RoleObjectPool.instance:removeHead(self.loader)

	GlobalDispatcher:removeListener(GlobalNotify.BroadcastCurVipLevel, self.updateState, self)
	self:setWithTag(0)
end

return HeadCell
