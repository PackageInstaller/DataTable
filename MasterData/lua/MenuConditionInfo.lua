--模块信息
local this = {}

function this.New()
	this.__index = this.__index or this
	local ins = {}
	setmetatable(ins, this)
	return ins
end


function this:InitData(openViewType, cfg)
	self.openViewType = openViewType
	self.cfg = cfg
	-- self.lockStr = ""
	-- self.isOpen = true
	-- self:CheckConditionIsOK()
	self.isOpen, self.lockStr = MenuMgr:CheckConditionIsOK(self.cfg.conditions)
end

function this:CheckConditionIsOK()
	self.isOpen, self.lockStr = MenuMgr:CheckConditionIsOK(self.cfg.conditions)
	return self.isOpen, self.lockStr
end

--是否已开启
-- function this:CheckConditionIsOK()
-- 	self.isOpen, self.lockStr = MenuMgr:CheckConditionIsOK(self.cfg.conditions)
-- 	local conditions = self.cfg.conditions
-- 	if(conditions == nil) then
-- 		self.isOpen = true
-- 	else
-- 		self.isOpen = true
-- 		local b = true
-- 		for i, v in ipairs(conditions) do	
-- 			local _cfg = Cfgs.CfgOpenRules:GetByID(v)
-- 			if(_cfg.type == OpenConditionType.lv) then
-- 				b = PlayerClient:GetLv() >= _cfg.val
-- 				if(not b) then
-- 					local str = LanguageMgr:GetTips(1001)
-- 					self.lockStr = string.format(str, _cfg.val)
-- 				end
-- 			elseif(_cfg.type == OpenConditionType.section) then
-- 				if(_cfg.openTime) then
-- 					local weekIndex = CSAPI.GetWeekIndex()
-- 					b = m.openTime[weekIndex] == 1
-- 					if(not b) then
-- 						self.lockStr = _cfg.lock_desc
-- 					end
-- 				end
-- 				if(b) then
-- 					b = DungeonMgr:CheckDungeonPass(_cfg.val)
-- 					if(not b) then
-- 						local sectionCfg = Cfgs.MainLine:GetByID(_cfg.val)
-- 						local str = LanguageMgr:GetTips(1002)
-- 						self.lockStr = string.format(str, sectionCfg.chapterID)
-- 					end
-- 				end			
-- 			elseif(_cfg.type == OpenConditionType.guide) then
-- 				b = GuideMgr:IsComplete(_cfg.val)
-- 				if(not b) then
-- 					self.lockStr = _cfg.guide_tips
-- 				end
-- 			end
-- 			if(not b) then
-- 				self.isOpen = false
-- 				break
-- 			end
-- 		end
-- 	end
-- 	return self.isOpen
-- end
function this:GetOpenViewType()
	return self.openViewType
end

function this:GetCfg()
	return self.cfg
end

function this:GetIsOpen()
	return self.isOpen
end

function this:GetLockStr()
	return self.lockStr
end

function this:GetID()
	return self.cfg and self.cfg.id or nil
end

function this:GetFatherView()
	return self.cfg and self.cfg.fatherView or nil
end

function this:GetIcon()
	if(self:NeedOpenTips()) then
		return self.cfg and self.cfg.icon or nil
	else
		return nil
	end
end

function this:GetCondition()
	return self.cfg and self.cfg.conditions or nil
end

function this:NeedOpenTips()
	return self.cfg and self.cfg.open_tips == 1 or false
end

return this 