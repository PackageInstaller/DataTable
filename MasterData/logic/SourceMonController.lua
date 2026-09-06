-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcemon/controller/SourceMonController.lua

module("logic.extensions.sourcemon.controller.SourceMonController", package.seeall)

local SourceMonController = class("SourceMonController", BaseController)

function SourceMonController:ctor()
	SourceMonController.super.ctor(self)
	SourcemonAgent.instance:addListener(SourcemonAgent.PM_UserSourcemonChangeNotifyRes, self.onInfoChange, self)
end

function SourceMonController:onInit()
	self.lightList = {}
end

function SourceMonController:onReset()
	return
end

function SourceMonController:onInfoChange(status, msg)
	if status == 0 then
		SourceMonModel.instance:changeInfo(msg)
	end
end

function SourceMonController:getInfo(callBack)
	if self.hasInit == true then
		GameUtil.callBack(callBack)
	else
		SourcemonAgent.instance:sendPM_LoadUserSourcemonReq(function(msg)
			self.hasInit = true

			SourceMonModel.instance:changeInfo(msg)
			GameUtil.callBack(callBack)
		end)
	end
end

function SourceMonController:sendLvlup(petId, slotId, sourcemonId, isBatchSwallow, callBack)
	local bagPetMo = BagPetsController.instance:getPet(petId)
	local mons = {}
	local mo = mons[slotId + 1]
	local smo = SourceMonModel.instance:getMonById(sourcemonId)

	SourcemonAgent.instance:sendPM_PetSwallowSourcemonReq(petId, slotId, sourcemonId, isBatchSwallow, function(msg)
		local level = msg.level

		if level > mo.level then
			print(">>>升级成功", mo.level, smo.level, level)
		else
			print(">>>升级失败", mo.level, smo.level, level)
		end

		local lvl1 = mo.level
		local lvl2 = smo.level
		local did = -1
		local mtype = -1

		if mo.defineId == -1 then
			did = smo.defineId
			mtype = smo.mutatedType
		else
			did = mo.defineId
			mtype = mo.mutatedType
		end

		GameUtil.callBack(callBack, level, lvl1, lvl2)
	end)
end

function SourceMonController:sendChange(petId, slotId, sourcemonId, callBack)
	local smo = SourceMonModel.instance:getMonById(sourcemonId)

	SourcemonAgent.instance:sendPM_EquipSourcemonReq(petId, slotId, sourcemonId, function(msg)
		local bagPetMo = BagPetsController.instance:getPet(petId)
		local mons = {}
		local mo = mons[slotId + 1]
		local level = -1
		local did = -1
		local mtype = -1

		level = math.max(mo.level, smo.level)
		did = smo.defineId
		mtype = smo.mutatedType

		GameUtil.callBack(callBack)
	end)
end

function SourceMonController:getMonById(monId)
	return SourceMonModel.instance:getMonById(monId)
end

function SourceMonController:setAttr(go, lvl)
	local attr = go:GetComponent("UIImageSpriteChange")
	local txt = goutil.findChild(go, "txtStar"):GetComponent("Text")

	if lvl > 0 then
		GameUtil.SetActive(go, true)

		txt.text = lvl

		attr:SetState(lvl - 1)
	else
		GameUtil.SetActive(go, false)
	end
end

function SourceMonController:playLight(view, con, lvl)
	local name

	if lvl <= 3 then
		-- block empty
	else
		name = lvl > 3 and lvl <= 6 and "fx_ui_yuanshou/fx_ui_yuanshou_lanse.prefab" or lvl > 6 and lvl <= 9 and "fx_ui_yuanshou/fx_ui_yuanshou_zise.prefab" or "fx_ui_yuanshou/fx_ui_yuanshou_chengse.prefab"
	end

	if not self.lightList[con] then
		local arr = {}

		for k, v in pairs(arr) do
			v:setActive(false)
		end

		if name ~= nil then
			local light = arr[name]

			if light then
				light:setActive(true)
			else
				light = UIEffectManager.instance:playEffect(view, name, con, 0, 90, true, nil, function()
					return
				end, function(ta, eff)
					return
				end)
				arr[name] = light

				light:setParent(view.mainGO.transform)
				light:setScale(1)
			end

			self.lightList[con] = arr
		end
	end
end

function SourceMonController:playSuc(view, name)
	if self.lastEff ~= nil then
		UIEffectManager.instance:stopEffect(self.lastEff)

		self.lastEff = nil
	end

	self.lastEff = UIEffectManager.instance:playEffect(view, "fx_ui_yuanshou/" .. name .. ".prefab", view.mainGO, 0, 0, false, nil, function()
		self.lastEff = nil
	end, function(ta, eff)
		self.lastEff = eff
	end)

	self.lastEff:setParent(view.mainGO.transform)
	self.lastEff:setScale(1)

	return self.lastEff
end

function SourceMonController:playEff(view, defineId, lvl1, lvl2, lvl, isClickClose, callBack)
	local winLoop = false

	winLoop = lvl1 < lvl and true or winLoop
	self.callBack = callBack

	print(">>> sourcemon", lvl1, "+", lvl2, "=", lvl)

	local con, eff1

	eff1 = UIEffectManager.instance:playEffect(view, "fx_ui_yuanshou/fx_ui_shengjichushizhuang.prefab", view.mainGO, 0, 0, winLoop, nil, function()
		self.eff = nil

		self:closeEff()
	end, function(ta, eff)
		self.eff = eff

		local go = eff.effGo
		local att1 = goutil.findChild(go, "num01_change"):GetComponent("UIImageSpriteChange")
		local txt1 = goutil.findChild(go, "num01_change/txtStar"):GetComponent("Text")
		local att2 = goutil.findChild(go, "num02_change"):GetComponent("UIImageSpriteChange")
		local txt2 = goutil.findChild(go, "num02_change/txtStar"):GetComponent("Text")
		local imgs = goutil.findChild(go, "num03_change/imgs")
		local img = goutil.findChild(go, "diban_change"):GetComponent("UIImageSpriteChange")

		con = goutil.findChild(go, "con")

		local cfg = SourceMonConfig.instance:getCfgById(defineId)

		self.roleEff = RoleObjectPool.instance:addRoleToParent(self.roleEff, checknumber(cfg.modelId), con, 0.3)

		if lvl > lvl1 then
			img:SetState(0)
		else
			img:SetState(1)
		end

		att1:SetState(lvl1 - 1)

		txt1.text = "" .. lvl1

		att2:SetState(lvl2 - 1)

		txt2.text = "" .. lvl2

		local tarPoxY = (lvl - 1) * -128 + -3840

		local function closeEff()
			self:closeEff()
		end

		self:startRollNum(imgs, tarPoxY, view, winLoop, closeEff)
	end)

	eff1:setParent(view.mainGO.transform)
	eff1:setScale(1)
end

function SourceMonController:closeEff()
	print(">>>>>播放结束")

	if self.eff ~= nil then
		UIEffectManager.instance:stopEffect(self.eff)

		self.eff = nil
	end

	self:clearAllTimer()

	self.roleEff = RoleObjectPool.instance:removeRole(self.roleEff)

	GameUtil.callBack(self.callBack)

	self.callBack = nil
end

function SourceMonController:startRollNum(imgs, tarPoxY, view, win, callBack)
	Framework.TransformUtil.SetLocalPos(imgs.transform, 0, 0, 0)

	local lPoxY = 0
	local func, roll
	local playOnes = false

	self.rollTimers = {}

	function roll()
		if lPoxY == tarPoxY then
			if playOnes == false then
				playOnes = true

				if win then
					self:playSuc(view, "fx_ui_shengjichenggong")
				else
					self:playSuc(view, "fx_ui_shengjishibai")
				end
			end

			return
		end

		local localPosX, localPosY, localPosZ = Framework.TransformUtil.GetLocalPos(imgs.transform, nil, nil, nil)
		local deltaY = 0.1 * (tarPoxY - lPoxY)

		lPoxY = math.abs(deltaY) <= 1 and tarPoxY or lPoxY + deltaY

		Framework.TransformUtil.SetLocalPos(imgs.transform, localPosX, lPoxY % -1280, localPosZ)
	end

	local function startRoll()
		func = self:settimer(0, roll, nil, true)

		table.insert(self.rollTimers, func)
	end

	func = self:settimer(0.25, startRoll, nil, false)

	table.insert(self.rollTimers, func)

	func = self:settimer(2, function()
		self:clearAllTimer()
		GameUtil.callBack(callBack)
	end, nil, false)

	table.insert(self.rollTimers, func)
end

function SourceMonController:clearAllTimer()
	for i, func in ipairs(self.rollTimers) do
		removetimer(func)
	end

	self.rollTimers = {}
end

function SourceMonController:settimer(time, handler, handlerObj, loop)
	local func = GameUtil.handler(handler, handlerObj)

	settimer(time, func, nil, loop)

	return func
end

function SourceMonController:showTips(callBack)
	if GameUtil.getUserDayData("SourceMonController") == true then
		GameUtil.callBack(callBack)
	else
		TipsFacade.instance:openPopupWindowWithTog(lang("tip"), lang("你确定要自动操作直到源兽升级至8级吗？"), function()
			GameUtil.callBack(callBack)
		end, function()
			return
		end, function()
			GameUtil.saveUserDayData("SourceMonController", true)
		end, nil, nil, lang("今日内不再提示"))
	end
end

SourceMonController.instance = SourceMonController.New()

return SourceMonController
