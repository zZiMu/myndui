local inserted = false
function DBMCPHoTS()
	if inserted then return end
	tinsert(DBM.Counts, {	text	= "HoTS: Default",	value 	= "HoTS_Default", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Default\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Abathur",	value 	= "HoTS_Abathur", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Abathur\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Adjutant",	value 	= "HoTS_Adjutant", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Adjutant\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Angel",	value 	= "HoTS_Angel", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Angel\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Anubarak",	value 	= "HoTS_Anubarak", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Anubarak\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Arena",	value 	= "HoTS_Arena", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Arena\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Arthas",	value 	= "HoTS_Arthas", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Arthas\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Athena",	value 	= "HoTS_Athena", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Athena\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Barbarian",	value 	= "HoTS_Barbarian", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Barbarian\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Blackheart",	value 	= "HoTS_Blackheart", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Blackheart\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Brightwing",	value 	= "HoTS_Brightwing", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Brightwing\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Commodore",	value 	= "HoTS_Commodore", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Commodore\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Demon",	value 	= "HoTS_Demon", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Demon\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: DemonHunter",	value 	= "HoTS_DemonHunter", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\DemonHunter\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Diablo",	value 	= "HoTS_Diablo", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Diablo\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: D.Va",	value 	= "HoTS_Dva", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Dva\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: E.T.C.",	value 	= "HoTS_ETC", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\ETC\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Falstad",	value 	= "HoTS_Falstad", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Falstad\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Gardens",	value 	= "HoTS_Gardens", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Gardens\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Gazlowe",	value 	= "HoTS_Gazlowe", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Gazlowe\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Genji (Jp)",	value 	= "HoTS_Genji", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Genji\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Illidan",	value 	= "HoTS_Illidan", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Illidan\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Lady of Thorns",	value 	= "HoTS_Thorns", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\LadyOfThorns\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: LiLi",	value 	= "HoTS_LiLi", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\LiLi\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Malfurion",	value 	= "HoTS_Malfurion", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Malfurion\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Metzen",	value 	= "HoTS_Metzen", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Metzen\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Muradin",	value 	= "HoTS_Muradin", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Muradin\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Murky",	value 	= "HoTS_Murky", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Murky\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Necromancer",	value 	= "HoTS_Necro", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Necromancer\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Ravenlord",	value 	= "HoTS_Ravenlord", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\RavenLord\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Rehgar",	value 	= "HoTS_Rehgar", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Rehgar\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: SiegeTank",	value 	= "HoTS_SiegeTank", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\SiegeTank\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Snake",	value 	= "HoTS_Snake", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Snake\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Spider Queen",	value 	= "HoTS_SpiderQueen", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\SpiderQueen\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Stitches",	value 	= "HoTS_Stitches", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Stitches\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Tassadar",	value 	= "HoTS_Tassadar", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Tassadar\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Tychus",	value 	= "HoTS_Tychus", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Tychus\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: WitchDoctor",	value 	= "HoTS_WitchDoctor", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\WitchDoctor\\", max = 5})
	tinsert(DBM.Counts, {	text	= "HoTS: Zeratul",	value 	= "HoTS_Zeratul", path = "Interface\\AddOns\\DBM-CountPack-HoTS\\Zeratul\\", max = 5})
	inserted = true
end