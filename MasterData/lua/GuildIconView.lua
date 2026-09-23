--公会头像选择面板
local iconList={};
local currIconId=nil;
local currIndex=nil;
function Awake()
    layout = ComUtil.GetCom(sv, "UICircularScrollView")
	layout:Init(LayoutCallBack)
end

function LayoutCallBack(element)
	local index = tonumber(element.name) + 1
    local _data = iconList[index]
    local isSelect=false;
    if _data:GetSkinID()==currIconId then
        currIndex=index;
        isSelect=true
    end
	ItemUtil.AddCircularItems(element, "Guild/GuildIconItem", _data,{isSelect=isSelect}, OnClickIcon, 0.6)
end

function OnOpen()
    --获取公会会长所持有的角色信息，初始化头像列表
    iconList={}
    if data then
        currIconId=data.iconID;
    end
    local _datas = CRoleMgr:SortArr()
	for i, v in ipairs(_datas) do
		--local maxBreakLv = v:GetBreakLevel()
		local allSkins = v:GetAllSkinsArr()
		if(allSkins and #allSkins > 0) then
			for k, m in ipairs(allSkins) do
				if(m:CheckCanUseByMaxLV()) then
					m:SetRoleId(v:GetID())
					table.insert(iconList, m)
				end
			end
		end
    end
    layout:IEShowList(#iconList)
end

function OnClickIcon(tab)
    currIconId=tab.data:GetSkinID();
    if currIndex then
        layout:UpdateCell(currIndex);
    end
    currIndex=tab.index;
end

function OnClickOk()
    if data==nil or (data and data.iconID~=currIconId) then
        --修改了公会头像
        EventMgr.Dispatch(EventType.Guild_Icon_Change,currIconId);
    end
    view:Close();
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
sv=nil;
Content=nil;
view=nil;
end
----#End#----