-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcopen/config/FuncOpenConfig.lua

module("logic.extensions.funcopen.config.FuncOpenConfig", package.seeall)

local FuncOpenConfig = class("FuncOpenConfig", BaseConfig)

function FuncOpenConfig:onInit()
	FuncOpenConfig.super.onInit(self)

	self._cofigfunctionOpenCfg = nil
	self._dataList = nil
	self._mainUIFuncs = {}
end

function FuncOpenConfig:getNames()
	return {
		"function_open",
		"mainui_jump",
		"mainui_jump_right"
	}
end

function FuncOpenConfig:getMainUIFuncs()
	return self._mainUIFuncs
end

function FuncOpenConfig:handleConfig(name, content)
	if name == "mainui_jump" then
		self.mainuiJumpCfg = content
	elseif name == "mainui_jump_right" then
		self._mainui_jump_right = content
	elseif name == "function_open" then
		self._cofigfunctionOpenCfg = content
		self._cofigfunctionOpenCfgLevelupTip = {}
		self._dataList = {}
		self._viewNameMap = {}

		for _, v in ipairs(content.dataList) do
			if not v.isHide then
				table.insert(self._dataList, v)

				if not string.nilorempty(v.view) then
					self._viewNameMap[v.view] = self._viewNameMap[v.view] or {}

					table.insert(self._viewNameMap[v.view], v.funcId)
				end

				local keys = string.split(v.mainuiArea, "#")

				for _, key in ipairs(keys) do
					if not string.nilorempty(key) and GameEnum.MainUIFuncArea[key] ~= nil then
						local newKey = GameEnum.MainUIFuncArea[key]

						if self._mainUIFuncs[newKey] == nil then
							self._mainUIFuncs[newKey] = {}
						end

						table.insert(self._mainUIFuncs[newKey], v.funcId)
					end
				end
			end
		end

		for k, v in pairs(self._mainUIFuncs) do
			if k ~= GameEnum.MainUIFuncArea.Fixed then
				table.sort(v, function(a, b)
					a = self:getFunctionOpenById(a)
					b = self:getFunctionOpenById(b)

					if a.priority ~= b.priority then
						return a.priority < b.priority
					else
						return a.funcId < b.funcId
					end
				end)
			end
		end

		for k, v in pairs(content) do
			if v.openCondition and v.openCondition[1] and v.tipLevel then
				local lv = checknumber(v.tipLevel)

				if lv > 0 then
					self._cofigfunctionOpenCfgLevelupTip[lv] = self._cofigfunctionOpenCfgLevelupTip[lv] or {}

					local condition = ""

					if v.openCondition[1] == 1 then
						condition = langPara("通关%d-%d", v.openCondition[2], v.openCondition[3])
					elseif v.openCondition[1] == 2 then
						condition = langPara("%d级", v.openCondition[2])
					end

					table.insert(self._cofigfunctionOpenCfgLevelupTip[lv], {
						name = v.name,
						condition = condition
					})
				end
			end
		end
	end
end

function FuncOpenConfig:getFuncIdByViewNameList(viewName)
	if self._viewNameMap then
		return self._viewNameMap[viewName]
	end
end

function FuncOpenConfig:getLevelupTipCfgListByLevel(lv)
	if self._cofigfunctionOpenCfgLevelupTip then
		return self._cofigfunctionOpenCfgLevelupTip[lv]
	else
		return {}
	end
end

function FuncOpenConfig:getFunctionOpenById(id)
	local cfg = self._cofigfunctionOpenCfg[id]

	if cfg and cfg.isHide then
		return nil
	else
		return cfg
	end
end

function FuncOpenConfig:getFunctionOpens()
	return self._dataList
end

function FuncOpenConfig:getJumpCfgById(id)
	return self.mainuiJumpCfg[id]
end

function FuncOpenConfig:getJumpList()
	if self.mainuiJumpCfg then
		return self.mainuiJumpCfg.dataList
	end

	return {}
end

function FuncOpenConfig:getJumpRightCfgById(id)
	return self._mainui_jump_right[id]
end

function FuncOpenConfig:getJumpRightList()
	if self._mainui_jump_right then
		return self._mainui_jump_right.dataList
	end

	return {}
end

FuncOpenConfig.instance = FuncOpenConfig.New()

return FuncOpenConfig
