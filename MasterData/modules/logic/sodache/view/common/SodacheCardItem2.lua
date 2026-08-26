-- chunkname: @modules/logic/sodache/view/common/SodacheCardItem2.lua

module("modules.logic.sodache.view.common.SodacheCardItem2", package.seeall)

local SodacheCardItem2 = class("SodacheCardItem2", SodacheCardItem)

function SodacheCardItem2:initTypeGos()
	SodacheCardItem2.super.initTypeGos(self)

	self.goTypeNormalMap = self:getUserDataTb_()
	self.goTypeBackMap = self:getUserDataTb_()
	self.effect1Map = self:getUserDataTb_()
	self.effect2Map = self:getUserDataTb_()
	self.effect3Map = self:getUserDataTb_()

	for i = 1, 5 do
		self.effect1Map[i] = gohelper.findChild(self.goTypeMap[i], "vx_glow_level1")
		self.effect2Map[i] = gohelper.findChild(self.goTypeMap[i], "vx_glow_level2")
		self.effect3Map[i] = gohelper.findChild(self.goTypeMap[i], "vx_glow_level3")
		self.goTypeNormalMap[i] = gohelper.findChild(self.goTypeMap[i], "node_card")
		self.goTypeBackMap[i] = gohelper.findChild(self.goTypeMap[i], "node_cardback")
		self.txtNameMap[i] = gohelper.findChildText(self.goTypeNormalMap[i], "txt_Name")
	end
end

function SodacheCardItem2:getTypeInfoRoot(index)
	return self.goTypeNormalMap[index]
end

function SodacheCardItem2:_editableInitView()
	SodacheCardItem2.super._editableInitView(self)

	local parentGo = self:getTypeInfoRoot(5)

	self.goRelicRares = self:getUserDataTb_()

	for i = 1, 3 do
		self.goRelicRares[i] = gohelper.findChild(parentGo, "image_RelicRare_level" .. i)
	end

	self._anims = self:getUserDataTb_()

	for i, v in ipairs(self.goTypeMap) do
		self._anims[i] = gohelper.findComponentAnim(v)
	end

	self.goInfo = gohelper.findChild(self.go, "Info")
	self.goEx = gohelper.findChild(self.go, "Info/Right/go_Ex")
end

function SodacheCardItem2:setRelicImage(quality)
	local index = 1

	if quality == SodacheEnum.ItemQuality.Six then
		index = 3
	elseif quality == SodacheEnum.ItemQuality.Five then
		index = 2
	end

	for k, v in pairs(self.goRelicRares) do
		gohelper.setActive(v, k == index)
	end
end

function SodacheCardItem2:updateMo(...)
	SodacheCardItem2.super.updateMo(self, ...)

	local anim = self._anims[self.config.type]

	anim:Play("open", 0, 0)
	gohelper.setActive(self.goTypeNormalMap[self.config.type], false)
	gohelper.setActive(self.goInfo, false)
	gohelper.setActive(self.goTypeBackMap[self.config.type], true)
	gohelper.setActive(self.effect1Map[self.config.type], self.config.quality == SodacheEnum.ItemQuality.Four)
	gohelper.setActive(self.effect2Map[self.config.type], self.config.quality == SodacheEnum.ItemQuality.Five)
	gohelper.setActive(self.effect3Map[self.config.type], self.config.quality == SodacheEnum.ItemQuality.Six)
	gohelper.setActive(self.goEx, self.data.serverMo.dropType == 1)
end

function SodacheCardItem2:playAnim(callback, callobj, param)
	gohelper.setActive(self.goTypeNormalMap[self.config.type], true)

	local anim = self._anims[self.config.type]
	local animIndex = 1
	local time = 0.667
	local quality = self.config.quality

	if self.config.type == SodacheEnum.CardType.Status and self.config.subType == SodacheEnum.CardSubType.Status_Debuff then
		quality = math.min(quality, SodacheEnum.ItemQuality.Five)
	end

	if quality == SodacheEnum.ItemQuality.Six then
		animIndex = 3
		time = 2.3
	elseif quality == SodacheEnum.ItemQuality.Five and self.config.type == SodacheEnum.CardType.Offering then
		animIndex = 2
		time = 1.433
	end

	if anim then
		anim:Play("flip" .. animIndex)
	end

	self._cb = callback
	self._cbobj = callobj
	self._cbparam = param

	TaskDispatcher.runDelay(self._playAnimFinish, self, time)
end

function SodacheCardItem2:_playAnimFinish()
	gohelper.setActive(self.goInfo, true)

	if self._cb then
		self._cb(self._cbobj, self._cbparam)
	end
end

function SodacheCardItem2:onDestroy()
	TaskDispatcher.cancelTask(self._playAnimFinish, self)
end

return SodacheCardItem2
