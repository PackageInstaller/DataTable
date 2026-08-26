-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessEffectComp.lua

module("modules.logic.autochess.main.view.comp.AutoChessEffectComp", package.seeall)

local AutoChessEffectComp = class("AutoChessEffectComp", LuaCompBase)

function AutoChessEffectComp:init(go)
	self.go = go
	self.goEffPointU = gohelper.findChild(go, "eff_up")
	self.goEffPointD = gohelper.findChild(go, "eff_down")
	self.effectTblMap = self:getUserDataTb_()
	self.cacheEffectTblMap = self:getUserDataTb_()
end

function AutoChessEffectComp:playEffect(effectCo, param)
	if type(effectCo) == "number" then
		effectCo = lua_auto_chess_effect.configDict[effectCo]
	end

	if effectCo then
		if effectCo.soundId ~= 0 then
			AudioMgr.instance:trigger(effectCo.soundId)
		end

		local pos = AutoChessEnum.EffectPos[effectCo.position]

		if not string.nilorempty(effectCo.offset) then
			local offset = string.splitToVector2(effectCo.offset, ",")

			pos = pos - offset
		end

		if not string.nilorempty(effectCo.nameUp) then
			local param1 = {
				pos = pos,
				effectName = effectCo.nameUp,
				parentGo = self.goEffPointU,
				loop = effectCo.loop,
				duration = effectCo.duration,
				flyPos = param and param.flyPos,
				value1 = param and param.value1
			}

			self:activeEffect(param1)
		end

		if not string.nilorempty(effectCo.nameDown) then
			local param1 = {
				pos = pos,
				effectName = effectCo.nameDown,
				parentGo = self.goEffPointD,
				loop = effectCo.loop,
				duration = effectCo.duration
			}

			self:activeEffect(param1)
		end

		return effectCo.duration
	end

	return 0
end

function AutoChessEffectComp:activeEffect(param)
	local effectName = param.effectName
	local time = param.duration
	local cacheEffectTbl = self:getCacheEffectTbl(effectName)

	if cacheEffectTbl and cacheEffectTbl[1] then
		local effectGo = table.remove(cacheEffectTbl, 1)
		local effectTbl = self:getEffectTbl(effectName)

		table.insert(effectTbl, effectGo)
		gohelper.setActive(effectGo, true)

		if param.flyPos then
			self:moveEffect(effectGo, param.flyPos, time)
		elseif effectName == "autochess_coin_take" then
			local txtCoin = gohelper.findChildText(effectGo, "coin/txt_coin")

			txtCoin.text = "+" .. param.value1
		end

		if param.loop ~= 1 then
			self:cacheEffect(effectName, time)
		end
	else
		AutoChessEffectMgr.instance:loadRes(param, self.loadResCallback, self)
	end
end

function AutoChessEffectComp:loadResCallback(effectGo, param)
	local effectName = param.effectName
	local time = param.duration
	local effectTbl = self:getEffectTbl(effectName)

	table.insert(effectTbl, effectGo)
	gohelper.addChild(param.parentGo, effectGo)
	recthelper.setAnchor(effectGo.transform, param.pos.x, param.pos.y)

	if param.flyPos then
		self:moveEffect(effectGo, param.flyPos, time)
	elseif effectName == "autochess_coin_take" then
		local txtCoin = gohelper.findChildText(effectGo, "coin/txt_coin")

		txtCoin.text = "+" .. param.value1
	end

	if param.loop ~= 1 then
		self:cacheEffect(effectName, time)
	end
end

function AutoChessEffectComp:cacheEffect(effectName, time)
	local tbl = self:getEffectTbl(effectName)
	local cacheTbl = self:getCacheEffectTbl(effectName)

	if time == 0 then
		local effectGo = table.remove(tbl, 1)

		table.insert(cacheTbl, effectGo)
		gohelper.setActive(effectGo, false)
	else
		TaskDispatcher.runDelay(function()
			local effectGo = table.remove(tbl, 1)

			table.insert(cacheTbl, effectGo)
			gohelper.setActive(effectGo, false)
		end, self, time)
	end
end

function AutoChessEffectComp:removeEffect(effectId)
	local effectCo = lua_auto_chess_effect.configDict[effectId]

	for name, effectTbl in pairs(self.effectTblMap) do
		if name == effectCo.nameUp or name == effectCo.nameDown then
			local cacheTbl = self:getCacheEffectTbl(name)

			for i = #effectTbl, 1, -1 do
				gohelper.setActive(effectTbl[i], false)
				table.insert(cacheTbl, effectTbl[i])

				effectTbl[i] = nil
			end
		end
	end
end

function AutoChessEffectComp:moveEffect(effectGo, position, time)
	if effectGo then
		local anchorPos = recthelper.rectToRelativeAnchorPos(position, effectGo.transform.parent)
		local rectTrs = effectGo.transform

		recthelper.setAnchor(rectTrs, 0, 0)

		local direction = Vector2.Normalize(position - effectGo.transform.position)
		local toDirection = Vector2(direction.x, 0)
		local angel = Vector2.Angle(direction, toDirection)

		transformhelper.setLocalRotation(rectTrs, 1, 1, angel)
		ZProj.TweenHelper.DOAnchorPos(rectTrs, anchorPos.x, anchorPos.y, time, nil, nil, nil, EaseType.Linear)
	end
end

function AutoChessEffectComp:hideAll()
	for name, effectTbl in pairs(self.effectTblMap) do
		local cacheTbl = self:getCacheEffectTbl(name)

		for i = #effectTbl, 1, -1 do
			gohelper.setActive(effectTbl[i], false)
			table.insert(cacheTbl, effectTbl[i])

			effectTbl[i] = nil
		end
	end
end

function AutoChessEffectComp:getEffectTbl(name)
	self.effectTblMap[name] = self.effectTblMap[name] or {}

	return self.effectTblMap[name]
end

function AutoChessEffectComp:getCacheEffectTbl(name)
	self.cacheEffectTblMap[name] = self.cacheEffectTblMap[name] or {}

	return self.cacheEffectTblMap[name]
end

return AutoChessEffectComp
