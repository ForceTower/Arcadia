//
//  DisciplineMapper.swift
//  Arcadia
//
//  Created by João Santos Sena on 12/07/23.
//

extension DisciplineCompleteDTO {
    func asDisciplineData() -> DisciplineData {
        return DisciplineData(
            id: self.id,
            disciplineId: self.activity.id,
            name: self.activity.name.trimmingCharacters(in: .whitespaces),
            code: self.activity.code.trimmingCharacters(in: .whitespaces),
            program: self.activity.program?.trimmingCharacters(in: .whitespaces),
            hours: self.activity.hours,
            department: self.activity.department?.name.trimmingCharacters(in: .whitespaces),
            classes: self.classes.items.map({ clazz in
                DisciplineClass(
                    id: clazz.id,
                    groupName: clazz.description.trimmingCharacters(in: .whitespaces),
                    type: clazz.type.trimmingCharacters(in: .whitespaces),
                    teacher: clazz.teachers.items.first?.person,
                    hours: clazz.groupDetails.hours,
                    program: clazz.groupDetails.program?.trimmingCharacters(in: .whitespaces),
                    allocations: clazz.allocations?.items ?? [],
                    lectures: clazz.lectures?.items.map({ lecture in
                        Lecture(
                            ordinal: lecture.ordinal,
                            situation: lecture.situation,
                            date: lecture.date,
                            subject: lecture.subject?.trimmingCharacters(in: .whitespaces),
                            materials: lecture.materials?.items.map({ material in
                                LectureMaterial(
                                    id: material.id,
                                    description: material.description.trimmingCharacters(in: .whitespaces),
                                    url: material.url.link.href)
                            }) ?? [])
                    }) ?? [])
            }),
            evaluations: self.evaluations?.items.map({ evaluation in
                ClassEvaluation(
                    name: evaluation.name?.trimmingCharacters(in: .whitespaces),
                    grades: evaluation.grades?.items.map({ grade in
                        ClassGrade(
                            ordinal: grade.ordinal,
                            name: grade.name.trimmingCharacters(in: .whitespaces),
                            nameShort: grade.nameShort.trimmingCharacters(in: .whitespaces),
                            date: grade.date,
                            weight: grade.weight,
                            value: grade.grade?.value)
                    }) ?? [])
            }) ?? [],
            result: self.result)
    }
}
