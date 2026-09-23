--只处理 RandRewardType.ITEM && ITEM_TYPE.CARD
--[[    RandRewardType = {}
RandRewardType.TEMPLATE = 1 --：嵌套模板
RandRewardType.ITEM = 2 --：物品
RandRewardType.CARD = 3 --：卡牌
RandRewardType.EQUIP = 4 --：装备
RandRewardType.ID = 5 --：其他模块Id类型
]]
-- 掉落类型type   data:{id=,num=,type=}
function Awake()
	CSAPI.PlayUISound("ui_popup_open")
end

function OnOpen()
	if(data.type == RandRewardType.ITEM) then
		cfg = Cfgs.ItemInfo:GetByID(data.id)
		if(cfg.type == ITEM_TYPE.CARD) then
			SetData()
			SetName()
			SetDesc()
		end
	end
end

function SetData()
	if(data.type == RandRewardType.ITEM) then
		local result = RoleMgr:GetFakeData(cfg.card_id)
		SetGrid(result)
	end
end
function SetGrid(result)
	if(roleItemN == nil) then
		ResUtil:CreateUIGOAsync("RoleCard/RoleLittleCard", gridNode, function(go)
			roleItemN = ComUtil.GetLuaTable(go)
			roleItemN.Refresh(result)
			roleItemN.SetLv(0)
		end)
	end
end

function SetName()
	CSAPI.SetText(txt_name, cfg.name)
end

function SetDesc()
	CSAPI.SetText(txt_desc, cfg.describe or "")
end

function OnClickReturn()
	Close();
end
function Close()
	view:Close()
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
root=nil;
top=nil;
gridNode=nil;
txt_desc=nil;
currNumObj=nil;
txt_has=nil;
txt_currNum=nil;
txt_name=nil;
view=nil;
end
----#End#----