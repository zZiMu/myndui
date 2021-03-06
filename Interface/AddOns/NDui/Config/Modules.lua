-- Configure 配置页面
local _, ns = ...
local _, C = unpack(ns)

-- BUFF/DEBUFF相关
C.Auras = {
	IconSize		= 32,													-- BUFF及相关职业助手图标大小
	IconsPerRow		= 14,													-- BUFF每行个数
	Spacing			= 6,													-- BUFF图标间距
	BuffPos			= {"TOPRIGHT", Minimap, "TOPLEFT", -10, -5},			-- BUFF默认位置

	BHPos			= {"CENTER", UIParent, "CENTER", 0, -206},				-- 血DK助手默认位置
	StaggerPos		= {"CENTER", UIParent, "CENTER", 0, -206},				-- 坦僧工具默认位置
	TotemsPos		= {"CENTER", UIParent, "CENTER", 0, -206},				-- 图腾助手默认位置
	HunterToolPos	= {"CENTER", UIParent, "CENTER", 0, -206},				-- 生存猎助手默认位置
	FamiliarPos		= {"CENTER", UIParent, "CENTER", 0, -240},				-- 奥法魔宠默认位置
	StatuePos		= {"CENTER", UIParent, "CENTER", 0, -240},				-- 武僧雕像默认位置

	-- 技能监控各组初始位置

	EnchantAuraPos			= {"BOTTOMRIGHT", UIParent, "CENTER", -200, -99},	-- 附魔及饰品分组
	PlayerAuraPos			= {"BOTTOMRIGHT", UIParent, "CENTER", -200, -165},	-- 玩家光环分组
	PlayerSpecialAuraPos	= {"BOTTOMRIGHT", UIParent, "CENTER", -200, -136},	-- 玩家重要光环分组
	TargetAuraPos			= {"BOTTOMLEFT", UIParent, "CENTER", 200, -165},	-- 目标光环分组
	TargetSpecialAuraPos	= {"BOTTOMLEFT", UIParent, "CENTER", 200, -128},	-- 目标重要光环分组
	FocusSpecialAuraPos		= {"BOTTOMLEFT", UIParent, "LEFT", 5, -130},		-- 焦点重要光环分组
	RaidBuffPos				= {"BOTTOMRIGHT", UIParent, "CENTER", -200, 200},	-- 团队增益分组
	RaidDebuffPos			= {"BOTTOMLEFT", UIParent, "CENTER", 200, 200},	-- 团队减益分组
	SpellCDPos				= {"LEFT", UIParent, "LEFT", 5, -30},				-- 技能冷却计时分组
	EnchantCDPos			= {"LEFT", UIParent, "LEFT", 200, -30},			-- 物品冷却计时分组
	InternalCDPos			= {"BOTTOMLEFT", UIParent, "CENTER", 499, -210},	-- 法术内置冷却分组
}

-- 头像相关
C.UFs = {
	Playercb		= {"BOTTOM", UIParent, "BOTTOM", 13, 175},				-- 玩家施法条默认位置
	PlayercbSize	= {280, 20},											-- 玩家施法条尺寸

	Targetcb		= {"BOTTOM", UIParent, "BOTTOM", 13, 335},				-- 目标施法条默认位置
	TargetcbSize	= {300, 20},											-- 目标施法条尺寸

	Focuscb			= {"CENTER", UIParent, "CENTER", 13, 150},				-- 焦点施法条默认位置
	FocuscbSize		= {320, 20},											-- 焦点施法条尺寸

	PlayerPos		= {"BOTTOMRIGHT", UIParent, "BOTTOM", -200, 280},		-- 玩家框体默认位置
	PetPos			= {"BOTTOMRIGHT", UIParent, "BOTTOM", -75, 278},		-- 宠物框体默认位置

	TargetPos		= {"BOTTOMLEFT", UIParent, "BOTTOM", 200, 280},		-- 目标框体默认位置
	ToTPos			= {"BOTTOMLEFT", UIParent, "BOTTOM", 75, 278},			-- 目标的目标框体默认位置

	FocusPos		= {"LEFT", UIParent, "LEFT", 5, -150},					-- 焦点框体默认位置
	FoTPos			= {"LEFT", UIParent, "LEFT", 215, -153},				-- 焦点目标框体默认位置

	PlayerPlate		= {"BOTTOM", UIParent, "BOTTOM", 0, 280},				-- 玩家姓名板默认位置
	BarPos			= {"TOPLEFT", 12, 4},									-- 资源条位置（以自身头像为基准）
	BarSize			= {150, 5},												-- 资源条的尺寸（宽，长）
	BarMargin		= 2,													-- 资源条间隔
}

-- 小地图
C.Minimap = {
	Pos				= {"TOPRIGHT", UIParent, "TOPRIGHT", -7, -7},			-- 小地图默认位置
}

-- 美化及皮肤
C.Skins = {
	MicroMenuPos	= {"BOTTOM", UIParent, "BOTTOM", 0, 1},				-- 微型菜单默认坐标
	RMPos			= {"TOP", UIParent, "TOP", 0, 0},						-- 团队工具默认坐标
}

-- 鼠标提示框
C.Tooltips = {
	TipPos			= {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -55, 230},	-- 鼠标提示框默认位置
}

-- 信息条
C.Infobar = {
	Guild	 		= true,												-- 公会信息
	GuildPos 		= {"TOPLEFT", UIParent, "TOPLEFT", 20, -7},			-- 公会信息位置
	Friends 		= true,												-- 好友模块
	FriendsPos 		= {"TOPLEFT", UIParent, "TOPLEFT", 125, -7},			-- 好友模块位置
	System			= true,												-- 帧数/延迟
	SystemPos		= {"TOPLEFT", UIParent, "TOPLEFT", 230, -7},			-- 帧数/延迟位置
	Location		= true,												-- 区域信息
	LocationPos		= {"TOPLEFT", UIParent, "TOPLEFT", 410, -7},			-- 区域信息位置

	Spec			= true,												-- 天赋专精
	SpecPos			= {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -400, 7},	-- 天赋专精位置
	Memory			= true,												-- 内存占用
	MemoryPos		= {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -310, 7},	-- 内存占用位置
	MaxAddOns		= 12,													-- 插件信息显示数量
	Durability		= true,												-- 耐久度
	DurabilityPos	= {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -195, 7},	-- 耐久度位置
	Gold			= true,												-- 金币信息
	GoldPos			= {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -95, 7},	-- 金币信息位置
	Time			= true,												-- 时间信息
	TimePos			= {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -20, 7},	-- 时间信息位置

	Fonts			= {STANDARD_TEXT_FONT, 13, "OUTLINE"},					-- 字体
}