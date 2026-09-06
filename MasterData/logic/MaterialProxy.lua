-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/MaterialProxy.lua

module("logic.extensions.material.proxy.MaterialProxy", package.seeall)

local MaterialProxy = class("MaterialProxy")

function MaterialProxy:ctor(luaCls)
	self.luaCls = luaCls

	NotifyDispatcher.extend(self)

	self.assetGo = nil
	self.cellLua = nil
	self.binder = nil
	self.autoTips = true
	self.view = nil
	self.isAddToPool = true

	self:initBinder()
end

function MaterialProxy:setBgActive(isActive)
	return
end

function MaterialProxy:initBinder()
	local this = self

	self.binder = setmetatable({
		_getter = {},
		_getterList = {}
	}, {
		__index = function(mytable, key)
			return function(mytable, ...)
				local arg = {
					...
				}

				if this.cellLua ~= nil then
					local func = this.cellLua[key]

					if func ~= nil then
						return func(this.cellLua, unpack(arg))
					end
				else
					mytable._getter[key] = arg

					table.insert(mytable._getterList, key)
				end

				return 0
			end
		end
	})
end

function MaterialProxy:callAllBinder()
	if self.cellLua ~= nil then
		local list = self.binder._getterList
		local getter = self.binder._getter

		for i = 1, #list do
			local key = list[i]
			local arg = getter[key]
			local func = self.cellLua[key]

			if func ~= nil then
				func(self.cellLua, unpack(arg))
			elseif enableDebug then
				error("Cell 中 没有找到 方法：" .. key .. " [" .. self.luaCls.__cname .. "]")
			end
		end

		self.binder._getter = {}
		self.binder._getterList = {}
	end
end

function MaterialProxy:getData()
	return self.data
end

function MaterialProxy:initData()
	local data = MaterialModel.instance:getMaterialMo(self.type, self.globalId)

	self:setData(data)
end

function MaterialProxy:setSelected(boo)
	self.binder:setSelected(boo)
end

function MaterialProxy:setCallBack(cb)
	self.binder:setCallBack(cb)
end

function MaterialProxy:setData(data)
	self.data = data

	self.binder:setData(data)
end

function MaterialProxy:initCfg(matType, cfgId)
	self.type = matType
	self.cfgId = cfgId

	self.binder:initCfg(matType, cfgId)
end

function MaterialProxy:setCfgData(cfg)
	self.binder:setCfgData(cfg)
end

function MaterialProxy:callWhenCom(callBack, ...)
	self.initedCallBack = callBack
	self.parms = {
		...
	}

	if self.cellLua ~= nil then
		GameUtil.callBack(self.initedCallBack, unpack(self.parms))
	end
end

function MaterialProxy:setFlag(flag)
	self.flag = flag
end

function MaterialProxy:getView()
	return self.view
end

function MaterialProxy:setAutoTips(boo)
	self.autoTips = boo

	self.binder:setAutoTips(boo)
end

function MaterialProxy:setGray(boo)
	if self.binder then
		self.binder:setGray(boo)
	end
end

function MaterialProxy:dispose()
	self.autoTips = true
	self.initedCallBack = nil

	self.binder:dispose()
end

function MaterialProxy:destroy()
	self.autoTips = true
	self.initedCallBack = nil

	self.binder:destroy()
	goutil.destroy(self.view)

	self.assetGo = nil
	self.view = nil
end

function MaterialProxy:addChildToParent(parent)
	if parent and parent.gameObject then
		GameUtil.SetActive(self.view, true)
		goutil.addChildToParent(self.view, parent.gameObject)
	end
end

function MaterialProxy:loadView(urlOrGo)
	if type(urlOrGo) == "string" then
		self.view = goutil.create(self.luaCls.__cname)

		local trans = self.view:GetComponent(goutil.Type_RectTransform)

		trans.anchorMin = Vector2.New(0.5, 0.5)
		trans.anchorMax = Vector2.New(0.5, 0.5)
		trans.pivot = Vector2.New(0, 1)

		goutil.setWidth(trans, 0)
		goutil.setHeight(trans, 0)
		MaterialMgr.instance:loadPrefab(urlOrGo, GameUtil.handler(self.loadViewEnd, self))
	else
		self.view = urlOrGo

		self:addLuaOnce(urlOrGo, urlOrGo)
	end

	local flag = GameUtil.AddLuaOnce(self.view, MaterialFlag)

	flag:setProxy(self)
	self:setFlag(flag)
end

function MaterialProxy:loadViewEnd(go)
	if goutil.isNil(self.view) then
		goutil.destroy(go, true)

		return
	end

	local trans2 = go:GetComponent(goutil.Type_RectTransform)

	trans2.pivot = Vector2.New(0.5, 0.5)

	goutil.addChildToParent(go, self.view)
	uGuiUtil.setLocalPosition(go)
	self:addLuaOnce(go, self.view)
end

function MaterialProxy:addLuaOnce(go, view)
	self.assetGo = go

	if self.luaCls ~= nil then
		self.cellLua = GameUtil.AddLuaOnce(go, self.luaCls)

		self:callAllBinder()
	end

	if self.initedCallBack ~= nil then
		GameUtil.callBack(self.initedCallBack, unpack(self.parms))
	end
end

function MaterialProxy:removeLua()
	GameUtil.RemoveLua(self.assetGo, self.luaCls)
	GameUtil.RemoveLua(self.view, MaterialFlag)
end

function MaterialProxy:setNum(allnum, useNum)
	if self.binder then
		self.binder:setNum(allnum, useNum)
	end
end

function MaterialProxy:setNumStr(numStr)
	if self.binder then
		self.binder:setNumStr(numStr)
	end
end

return MaterialProxy
