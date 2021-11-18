
@startuml
skinparam ClassFontColor #003399
skinparam ClassAttributeFontColor #003399
skinparam CircledCharacterFontColor #003399
skinparam PackageFontColor #003399

skinparam ClassBackgroundColor #FFFFFFF

skinparam ClassBorderThickness 1.5
skinparam PackageBorderThickness 1.5

skinparam ClassBorderColor #003399
skinparam PackageBorderColor #003399

skinparam ClassFontStyle Meiryo UI
skinparam ClassAttributeFontStyle Meiryo UI
skinparam CircledCharacterFontStyle Meiryo UI
skinparam PackageFontStyle Meiryo UI

skinparam Shadowing false

hide <<MethodOrVariable>> members
hide <<MethodOrVariable>> stereotype


package Process <<frame>> {
	package Package {
		package File <<file>>{
			class GlobalMethod <<(M,#DDEEFF)MethodOrVariable>> 
			class LocalMethod <<(m,#99CCFF)MethodOrVariable>> 
			class GlobalVariable <<(V,#FFFFDD)MethodOrVariable>> 
			class LocalVariable <<(v,#FFFF99)MethodOrVariable>> 
			class Class {
				+ public_method()
				- private_method()
				+ public_variable
				- private_variable
			}
		}
	}
}


@enduml
