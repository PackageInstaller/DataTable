local this = {
	isNew = false,        --有新消息
	isSelect = false,       --当前选中
}

function this.New()
	this.__index = this.__index or this
	local ins = {}
	setmetatable(ins, this)
	return ins
end

function this:InitData(sFriendInfo)
	for i, v in pairs(sFriendInfo) do
		self[i] = v
	end
end

--获取名称，色码
function this:GetName()
	if(self:GetAlias() ~= "") then
		return self:GetAlias(), "blue"	
	end
	return self:GetOldName(), "" 
end

function this:GetOldName()
	return self.name or ""
end

function this:GetSex()
	return self.sel_card_ix or 1
end

function this:IsOnLine()
	return self.is_online or false
end

--在线或离线字段
function this:GetOnLine()
	if(self:IsOnLine()) then
		return LanguageMgr:GetByID(12015)
	elseif(self.last_save_time) then
		local timer = TimeUtil:GetTime() - self.last_save_time
		local tab = TimeUtil:GetTimeTab(timer)
		if(tab[1] > 0) then
			tab[1] = tab[1] > 7 and 7 or tab[1]
			return LanguageMgr:GetTips(6006, tab[1])
		elseif(tab[2] > 0) then
			return LanguageMgr:GetTips(6007, tab[2])
		else
			tab[3] = tab[3] <= 0 and 1 or tab[3]
			return LanguageMgr:GetTips(6008, tab[3])
		end
	else
		return ""
	end
end

function this:GetUid()
	return self.uid
end

function this:GetAlias()
	return self.alias or ""
end

function this:GetState()
	return self.state or 0
end

function this:GetLv()
	return self.level or 0
end

function this:GetAdd_time()
	return self.add_time or 0
end

function this:GetFriend_rate()
	return self.friend_rate or 0
end

--是否是好友
function this:IsFriend()
	return self:GetState() == eFriendState.Pass
end

function this:GetArmy_refuse_time()
	return self.army_refuse_time
end

--你邀请好友对战的时间
function this:GetYQTime()
	return 0 --todo
end

function this:GetWinCnt()
	return self.win_cnt or 0
end

function this:GetLostCnt()
	return self.lost_cnt or 0
end

function this:GetIconId()
	return self.icon_id or nil
end

function this:GetIconName()
	if(self:GetIconId()) then
		local cfgModel = Cfgs.character:GetByID(self:GetIconId())
		return cfgModel and cfgModel.icon or nil
	end
	return nil
end

--是否在pvp
function this:GetIsInPVP()
	return self.in_pvp or false
end

function this:IsDormOpen()
	return self.build_opens and self.build_opens[1] == 1
end

function this:IsTradingOpen()
	return self.build_opens and self.build_opens[2] == 1
end

---------------------------------------------------------------
--有新消息
function this:IsNewInfo(b)
	b = b == nil and false or b
	self.isNew = b
end

function this:IsNew()
	return self.isNew or false
end

--选中
function this:IsSelect(b)
	b = b == nil and false or b
	self.isSelect = b
end

function this:GetIsSelect()
	return self.isSelect or false
end

--是否已申请
function this:GetIsRecommend()
	return self:GetState() ~= eFriendState.None
end

--等待描述
function this:GetApplyMsg()
	return self.apply_msg or ""
end

--获取签名
function this:GetSign()
	return self.sign or ""
end

function this:GetFrameId()
	return self.icon_frame or 1
end

function this:GetTitle()
	return self.icon_title or 1
end

function this:GetRolePanelId()
	return self.role_panel_id or 1
end

function this:GetIconCardId()
	return self.icon_card or 1
end

return this 