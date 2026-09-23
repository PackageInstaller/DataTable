function SetIndex(_index)
	index = _index
end
function Refresh(_data)
	data = _data
	
	--index
	CSAPI.SetText(txtSort, index .. "")
	--name
	CSAPI.SetText(txtName, data.name)
	--items
	SetItems()
	--damage
	CSAPI.SetText(txtDamge, data.hurtCnt.."")
end

function SetItems()
	--封装数据
	local lNewDatas = {}
	local cardDatas = {}
	if(data and data.team) then
		for i, v in ipairs(data.team.data) do
			local _card = CharacterCardsData(v.card_info)
			table.insert(cardDatas, _card)
		end
	end	
	for i = 1, 5 do
		if(i <= #cardDatas) then
			table.insert(lNewDatas, cardDatas[i])
		else
			table.insert(lNewDatas, {})
		end
	end	
	
	lTeamGrids = lTeamGrids or {}
	ItemUtil.AddItems("RoleLittleCard/RoleLittleCard", lTeamGrids, lNewDatas, grid)
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
txtSort=nil;
txtName=nil;
txtDamge=nil;
grid=nil;
view=nil;
end
----#End#----