--台词基类
local this = {}

function this.New()
	this.__index = this.__index or this
	local ins = {}
	setmetatable(ins, this)
	return ins
end

--==============================--
--desc:
--time:2019-08-19 04:07:22
--@_id: CfgScriptEnum 表id
--@_sName:名称
--@_script:台词
--@_music:音效
--@_special:是不是特殊
--@return 
--==============================--
function this:InitData(_id, _roleLv, _roleID)
	self.id = _id
	self.roleLv = _roleLv
	self.roleID = _roleID
	self.cfg = Cfgs.CfgCardRoleVoice:GetByID(_id)
end

function this:GetArr()
	return self.cfg and self.cfg.infos or {}
end

--获取已获得的列表
function this:GetOpenArr()
	local arr = {}
	local infos = self:GetArr()
	if(#infos > 0) then
		local cRoleInfo = CRoleMgr:GetData(self.roleID)
		for i, v in ipairs(infos) do
			if(cRoleInfo:CheckAudioIsGet(v)) then
				table.insert(arr, v)
			end
		end
	end
	return arr
end

--获取音效（要可用）
function this:GetVoice(_type)
	local selectInfos = {}
	local infos = self:GetArr()
	if(infos) then
		for i = 1, #infos do
			if(infos[i].type == _type and(infos[i].openLv == nil or(self.roleLv >= infos[i].openLv))) then
				table.insert(selectInfos, infos[i])
				if(_type ~= RoleAudioType.touch) then
					break
				end
			end
		end
	end
	return selectInfos
end

--通过index获取条目
function this:GetVoiceByIndex(_index)
	local infos = self:GetArr()
	if(infos) then
		for i, v in ipairs(infos) do
			if(i == _index) then
				if(infos[i].openLv == nil or(self.roleLv >= infos[i].openLv)) then
					return v
				end
				break
			end
		end
	end
	return nil
end

return this 