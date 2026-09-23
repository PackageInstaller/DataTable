local curTag = nil

function OnOpen()
	oldTag = data:GetData().tag or 0
	curTag = oldTag
	datas = {}
	local cfgs = Cfgs.CfgCardTags:GetAll()
	for i, v in ipairs(cfgs) do
		table.insert(datas, v)
	end
	table.insert(datas, {id = 0, name1 = ""})
	
	SetItems()
end

function SetItems()
	items = items ~= nil and items or {}
	ItemUtil.AddItems("Role/RoleInfoTagItem", items, datas, gridParent, ClickCB, 1, {curTag})
end

function ClickCB(id)
	curTag = id
	SetItems()
end

function OnClickMask()
	view:Close()
end

function OnClickSure()
	if(oldTag ~= curTag) then
		PlayerProto:SetCardTag(data:GetID(), curTag)
	end
	view:Close()
end 