local isClick = false

--协战格子
function Refresh(_data)
	data = _data
	isClick = true
	if data then
		CSAPI.SetGOActive(addIcon, false)
		CSAPI.SetGOActive(icon,true)
		-- local card = CharacterCardsData()
		AddChild(data)
		CSAPI.SetGOActive(node, true)
	else
		CSAPI.SetGOActive(addIcon, true)
		CSAPI.SetGOActive(icon,false)
		CSAPI.SetGOActive(node, false)
	end
end

function AddChild(card)
	if card:GetSmallImg() then
		ResUtil.RoleCard:Load(icon, card:GetIcon())
		CSAPI.SetScale(icon, 0.67, 0.67)
	end
	CSAPI.SetText(txtName,card:GetName())
	CSAPI.SetText(txtLv,card:GetLv() .. "")
	CSAPI.SetText(txtProperty,card:GetProperty() .. "")
end

function OnClick()	
	if isClick then
		CSAPI.OpenView("RoleListSelectView", {cb = OnClickSureCB}, RoleListType.Support)
	end
end

function SetClick(b)
	isClick = b
end

--{role_tag = id ,role_tag = id ....}
function OnClickSureCB(curSupportCids)
	local teamData = TeamMgr:GetTeamData(eTeamType.Assistance)
	if(teamData) then
		teamData:ClearCard()
	end
	local index = 1
	for i, v in pairs(curSupportCids) do
		local _cardData = RoleMgr:GetData(v)
		local _type = index
		teamData:AddCard(GetTeamItemData({cardData = _cardData, type = _type}))
		index = index + 1
	end
	TeamMgr:UpdateDataByIndex(eTeamType.Assistance, teamData)
	--保存
	TeamMgr:SaveData(teamData, nil)
	
	EventMgr.Dispatch(EventType.Role_Card_Support)
end

function GetTeamItemData(_data)
	local tempData = {};
	tempData.cid = _data.cardData:GetID();
	local row = 1;
	local col = 1;
	if _data.type > 3 then
		row = math.floor(_data.type / 3) + 1;
		col = _data.type % 3;
	else
		row = 1;
		col = _data.type % 3;
	end
	tempData.row = row;
	tempData.col = col;
	return tempData;
end 
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
bgIcon=nil;
noIcon=nil;
clickNode=nil;
rootNode=nil;
view=nil;
end
----#End#----