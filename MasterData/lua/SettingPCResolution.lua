
local downListView
local SelectID=1;
local optionsData={};
local PCWindowSetKey="PCWindowSetKey"
---设置PC分辨率
function Awake()
    SelectID=PlayerPrefs.GetInt(PCWindowSetKey);
    if SelectID==0 then SelectID=3; end

    CreateData();
    for i, v in pairs(optionsData) do
        if optionsData[i].isSelect~=nil and optionsData[i].isSelect then
            local Title=optionsData[i]["Showname"]
            CSAPI.SetText(Resolutionbtn_Text,optionsData[i]["Showname"]);
            if tostring(Title)==tostring(LanguageMgr:GetTips(1044)) then
                SelectID=1;
                print("全屏")
            elseif tostring(Title)=="1920*1080" then
                SelectID=2;
                print("1920*1080")
            elseif tostring(Title)=="1280*720" then
                SelectID=3;
                print("1280*720")
            --elseif tostring(Title)=="640*480" then
            --    SelectID=4;
            --    print("640*480")
            end
        end
    end
    --txt1
    --ResolutionSet_txt
end

function OnEnable()
    transform.offsetMin = UnityEngine.Vector2(0, 0)
    transform.offsetMax = UnityEngine.Vector2(0, 0)
end
---打开选择
function OnClickSetResolutionbtn()
    if downListView==nil then
        local go=ResUtil:CreateUIGO("Setting/PCDownListView",gameObject.transform);
        downListView=ComUtil.GetLuaTable(go);
    end
    CreateData()
    pos=UnityEngine.Vector3(-365,0,0)
    print("---SelectID--->:"..SelectID)
    downListView.Show(UnityEngine.Vector3(536,-25,0),optionsData,SelectID);
    downListView.AddOnValueChange(OnDownValChange);
    downListView.AddOnClose(AddOnClose);
end
function CreateData()
    optionsData=
    {
        [1]=
        {
            ["name"]=LanguageMgr:GetTips(1044),
            ["Showname"]=LanguageMgr:GetTips(1044),
            ["id"]=1,
            ["index"]=1,
            --["itemID"]=1,
            ["enable"]=true,
            --["isSelect"]=SelectID==1,
            ["desc"]="",
        },
        [2]=
        {
            ["name"]=LanguageMgr:GetTips(1045).."1920*1080",
            ["Showname"]="1920*1080",
            ["id"]=1,
            ["index"]=2,
            ["enable"]=true,
            --["isSelect"]=SelectID==2,
            ["desc"]="",
        },
        [3]=
        {
            ["name"]=LanguageMgr:GetTips(1045).."1280*720",
            ["Showname"]="1280*720",
            ["id"]=1,
            ["index"]=3,
            ["enable"]=true,
            ["desc"]="",
        },
        --[4]=
        --{
        --    ["name"]=LanguageMgr:GetTips(1045).."640*480",
        --    ["Showname"]="640*480",
        --    ["id"]=1,
        --    ["index"]=4,
        --    --["itemID"]=4,
        --    ["enable"]=true,
        --    --["isSelect"]=SelectID==4,
        --    ["desc"]="",
        --},
    }
    for i, v in pairs(optionsData) do
        if optionsData[i].index~=nil and optionsData[i].index and optionsData[i].index==SelectID then
            optionsData[i]["itemID"]=1;
            optionsData[i]["isSelect"]=true;
            print("---SelectID:"..SelectID)
            break;
        end

    end
end

function OnDownValChange(options)
    --第一个数据是选中的
    --- 第二个是之前的
    if options then
        if options then
            local count=0;
            for i, v in pairs(options) do
                count=count+1
                if count==1 then
                    local index=options[i]["index"]
                    if index~=nil and index~=0 then
                        local Title=options[i]["Showname"]
                        CSAPI.SetText(Resolutionbtn_Text,Title);
                            print("Title:"..Title)
                            if tostring(Title)==tostring(LanguageMgr:GetTips(1044)) then
                                CSAPI.PCSetWindow(1920,1080,true,1)
                                SelectID=1;
                                print("全屏")
                            elseif tostring(Title)=="1920*1080"   then
                                CSAPI.PCSetWindow(1920,1080,false,2)
                                SelectID=2;
                                print("1920*1080")
                            elseif tostring(Title)=="1280*720"   then
                                CSAPI.PCSetWindow(1280,720,false,3)
                                SelectID=3;
                                print("1280*720")
                            --elseif tostring(Title)=="640*480"   then
                            --    CSAPI.PCSetWindow(640,480,false,4)
                            --    SelectID=4;
                            --    print("640*480")
                            end
                    end
                end
            end
        end
    end

end


function AddOnClose(_onClose)

   ----页面关闭通知

end