local itemPath = "Archive2/ArchiveRoleJQItem"

function Awake()
	layout = ComUtil.GetComInChildren(sv, "UICircularScrollView")
	layout:Init(LayoutCallBack)
end

function LayoutCallBack(element)
	local index = tonumber(element.name) + 1
	local _data = curDatas[index]
	ItemUtil.AddCircularItems(element, itemPath, _data)
end


function Refresh(_data, _selectSkin)
	data = _data
	curDatas = CRoleMgr:GetStory(data:GetID(), _selectSkin:GetSkinID())

	layout:IEShowList(#curDatas)

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
sv=nil;
view=nil;
end
----#End#----