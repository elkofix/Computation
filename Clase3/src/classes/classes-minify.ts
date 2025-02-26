export class student {
  constructor(
    public readonly id: number,
    public readonly name: string,
    public readonly age: number
  ) {}
}

export const gustavo = new student(1, "Gustavo", 29);
